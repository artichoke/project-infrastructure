locals {
  apex_domain      = data.aws_route53_zone.zone.name
  redirect_domains = [local.apex_domain, "www.${local.apex_domain}"]
  safe_name        = replace(local.apex_domain, ".", "-")
  bucket           = "artichoke-domain-redirect-${local.safe_name}"
}

data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

module "cert" {
  source = "../acm-cert-with-dns-verification"

  zone_id = data.aws_route53_zone.zone.zone_id
  domains = local.redirect_domains

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}

resource "aws_route53_record" "apex_ipv4" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = data.aws_route53_zone.zone.name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "apex_ipv6" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = data.aws_route53_zone.zone.name
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_ipv4" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "www"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_ipv6" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "www"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_s3_bucket" "this" {
  bucket = local.bucket

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "archive"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER_IR"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_logging" "this" {
  bucket        = aws_s3_bucket.this.id
  target_bucket = var.access_logs_bucket
  target_prefix = "v2/${local.bucket}/"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls   = true
  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

  lifecycle {
    prevent_destroy = true
  }
}

# tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "oac-domain-redirect-${local.safe_name}"
  description                       = "OAC for S3 bucket backing domain redirect from ${local.apex_domain} to ${var.redirect_to}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# The below lints are disabled for cost reasons and because the site deployed
# behind this cloudfront distribution is empty.
#
# tfsec:ignore:aws-cloudfront-enable-waf
# tfsec:ignore:aws-cloudfront-enable-logging
resource "aws_cloudfront_distribution" "this" {
  comment = "domain redirect ${local.apex_domain} to ${var.redirect_to}"

  enabled             = true
  wait_for_deployment = false
  is_ipv6_enabled     = true
  http_version        = "http2and3"
  price_class         = "PriceClass_All"

  aliases = local.redirect_domains

  viewer_certificate {
    acm_certificate_arn = module.cert.cert_arn
    ssl_support_method  = "sni-only"
    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html
    minimum_protocol_version = "TLSv1.2_2021"
  }

  default_cache_behavior {
    target_origin_id       = "main"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      headers      = []
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 30
    max_ttl     = 86400

    response_headers_policy_id = aws_cloudfront_response_headers_policy.this.id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.request_handler.arn
    }
  }

  origin {
    domain_name = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id   = "main"

    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_function" "request_handler" {
  name    = "cloudfront-${local.safe_name}-request-handler"
  runtime = "cloudfront-js-1.0"
  comment = "redirect request handler from ${local.apex_domain} to ${var.redirect_to}"
  publish = true
  code    = templatefile("${path.module}/request-handler.js", { redirect_to = var.redirect_to })
}

resource "aws_cloudfront_response_headers_policy" "this" {
  name    = "cloudfront-${local.safe_name}-response-headers"
  comment = "redirect domain from ${local.apex_domain} to ${var.redirect_to}"

  security_headers_config {
    # https://infosec.mozilla.org/guidelines/web_security#content-security-policy
    # https://infosec.mozilla.org/guidelines/web_security#x-frame-options
    content_security_policy {
      content_security_policy = "frame-ancestors 'none'; style-src 'self'; img-src 'self'; object-src 'none'; script-src 'none'; trusted-types; require-trusted-types-for 'script';"
      override                = true
    }

    # https://infosec.mozilla.org/guidelines/web_security#x-content-type-options
    content_type_options {
      override = true
    }

    # https://infosec.mozilla.org/guidelines/web_security#x-frame-options
    frame_options {
      frame_option = "DENY"
      override     = true
    }

    # https://infosec.mozilla.org/guidelines/web_security#referrer-policy
    referrer_policy {
      referrer_policy = "no-referrer"
      override        = true
    }

    # https://infosec.mozilla.org/guidelines/web_security#http-strict-transport-security
    strict_transport_security {
      access_control_max_age_sec = 63072000
      include_subdomains         = false
      preload                    = false
      override                   = true
    }

    # https://infosec.mozilla.org/guidelines/web_security#x-xss-protection
    xss_protection {
      protection = true
      mode_block = true
      override   = true
    }
  }
}
