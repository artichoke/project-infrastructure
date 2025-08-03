data "aws_route53_zone" "zone" {
  for_each = toset(keys(module.domain_data.google_site_verification_keys))
  name     = each.key
}

module "site_verification" {
  for_each = module.domain_data.google_site_verification_keys
  source   = "../google-site-verification"

  zone_id                = data.aws_route53_zone.zone[each.value.domain].zone_id
  site_verification_keys = each.value.site_verification_keys
}
