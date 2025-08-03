data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

data "dns_txt_record_set" "zone" {
  host = data.aws_route53_zone.zone.name
}

resource "aws_route53_record" "txt" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = data.aws_route53_zone.zone.name
  type    = "TXT"
  ttl     = "300"

  records = toset(compact(
    concat([
      for r in data.dns_txt_record_set.zone.records : startswith(r, "google-site-verification=") ? null : r
    ], formatlist("google-site-verification=%s", var.site_verification_keys))
  ))
}
