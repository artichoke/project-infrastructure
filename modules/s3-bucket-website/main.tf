resource "aws_s3_bucket" "this" {
  bucket = var.bucket

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"

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
  target_prefix = "v2/${var.bucket}/"

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

resource "aws_acm_certificate" "cert" {
  provider = aws.us_east_1

  domain_name               = var.domains[0]
  subject_alternative_names = slice(var.domains, 1, length(var.domains))
  validation_method         = "EMAIL"

  validation_option {
    domain_name       = var.domains[0]
    validation_domain = "artichokeruby.org"
  }

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_roles" "admin" {
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
  name_regex = ".*AWSAdministratorAccess.*"
}

resource "aws_cloudfront_origin_access_identity" "website" {
  comment = "static website ${var.domains[0]} access"
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "CloudFrontAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.website.iam_arn]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.this.arn}",
      "${aws_s3_bucket.this.arn}/*"
    ]
  }

  statement {
    sid    = "AdminAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = data.aws_iam_roles.admin.arns
    }

    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.this.arn}",
      "${aws_s3_bucket.this.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  policy = data.aws_iam_policy_document.this.json
}

# The below lints are disabled for cost reasons and because the site deployed
# behind this cloudfront distribution is a static website.
#
# tfsec:ignore:aws-cloudfront-enable-waf
# tfsec:ignore:aws-cloudfront-enable-logging
resource "aws_cloudfront_distribution" "website" {
  comment = "static website ${var.domains[0]}"

  enabled             = true
  wait_for_deployment = false
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "PriceClass_All"

  aliases = var.domains
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
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

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.request_handler.arn
    }

    function_association {
      event_type   = "viewer-response"
      function_arn = aws_cloudfront_function.response_handler.arn
    }
  }

  origin {
    domain_name = aws_s3_bucket.this.bucket_regional_domain_name
    origin_id   = "main"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.website.cloudfront_access_identity_path
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}

resource "aws_cloudfront_function" "request_handler" {
  name    = "cloudfront-${replace(var.domains[0], ".", "-")}-request-handler"
  runtime = "cloudfront-js-1.0"
  comment = "static website request handler ${var.domains[0]}"
  publish = true
  code    = file("${path.module}/request-handler.js")
}

resource "aws_cloudfront_function" "response_handler" {
  name    = "cloudfront-${replace(var.domains[0], ".", "-")}-response-handler"
  runtime = "cloudfront-js-1.0"
  comment = "static website response handler ${var.domains[0]}"
  publish = true
  code    = file("${path.module}/response-handler.js")
}

resource "aws_s3_object" "robots_txt" {
  bucket = aws_s3_bucket.this.id
  key    = "robots.txt"
  source = "${path.module}/robots.txt"

  etag = filemd5("${path.module}/robots.txt")
  content_type = "text/plain"

  server_side_encryption = "AES256"
}
