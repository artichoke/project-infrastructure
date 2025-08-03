locals {
  domain_name       = var.domains[0]
  alternative_names = slice(var.domains, 1, length(var.domains))
}

data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

resource "aws_acm_certificate" "this" {
  provider = aws.us_east_1

  domain_name               = local.domain_name
  subject_alternative_names = local.alternative_names
  validation_method         = "DNS"

  # use modern cryptography
  key_algorithm = "EC_prime256v1"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  provider = aws.us_east_1

  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this : record.fqdn]
}

resource "aws_route53_record" "this" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.zone.zone_id
}
