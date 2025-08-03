data "aws_route53_zone" "zone" {
  for_each = { for conf in module.domain_data.github_pages_config : conf.domain => conf }
  name     = each.key
}


module "github_pages" {
  for_each = { for conf in module.domain_data.github_pages_config : conf.domain => conf }
  source   = "../github-pages-domain-dns"

  zone_id             = data.aws_route53_zone.zone[each.key].zone_id
  github_organization = each.value.org
  include_apex        = each.value.include_apex
  subdomains          = each.value.subdomains
}
