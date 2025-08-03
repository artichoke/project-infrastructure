data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

data "dns_txt_record_set" "zone" {
  host = data.aws_route53_zone.zone.name
}

module "mx" {
  source = "../google-workspace-mx"

  zone_id = data.aws_route53_zone.zone.zone_id
}

module "dkim" {
  source = "../google-workspace-dkim"

  zone_id     = data.aws_route53_zone.zone.zone_id
  dkim_record = var.dkim_record
}

resource "aws_route53_record" "spf" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = data.aws_route53_zone.zone.name
  type    = "TXT"
  ttl     = "300"

  records = toset(compact(
    concat([
      for r in data.dns_txt_record_set.zone.records : startswith(r, "v=spf") ? null : r
    ], ["v=spf1 include:_spf.google.com ~all"])
  ))
}
