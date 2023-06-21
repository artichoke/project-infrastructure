data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "txt" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = data.aws_route53_zone.zone.name
  type    = "TXT"
  ttl     = "300"

  records = formatlist("google-site-verification=%s", var.site_verification_keys)

  lifecycle {
    prevent_destroy = true
  }
}
