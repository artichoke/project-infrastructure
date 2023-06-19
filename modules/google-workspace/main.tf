data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

module "mx" {
  source = "../google-workspace-mx"

  zone_id = var.zone_id
}

module "dkim" {
  source = "../google-workspace-dkim"

  zone_id     = var.zone_id
  dkim_record = var.dkim_record
}

resource "aws_route53_record" "txt" {
  zone_id = var.zone_id
  name    = data.aws_route53_zone.zone.name
  type    = "TXT"
  ttl     = "300"

  records = flatten([
    "v=spf1 include:_spf.google.com ~all",
    formatlist("google-site-verification=%s", var.site_verification_keys),
  ])

  lifecycle {
    prevent_destroy = true
  }
}
