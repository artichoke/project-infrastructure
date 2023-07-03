data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

# G Suite MX record values: https://support.google.com/a/answer/174125?hl=en
#
# Use "I signed up before 2023" configuration.

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = data.aws_route53_zone.zone.name
  type    = "MX"
  ttl     = "3600"

  records = [
    "1 ASPMX.L.GOOGLE.COM.",
    "5 ALT1.ASPMX.L.GOOGLE.COM.",
    "5 ALT2.ASPMX.L.GOOGLE.COM.",
    "10 ALT3.ASPMX.L.GOOGLE.COM.",
    "10 ALT4.ASPMX.L.GOOGLE.COM.",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

