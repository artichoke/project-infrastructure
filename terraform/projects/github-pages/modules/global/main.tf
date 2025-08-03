locals {
  pages = [
    { org = "artichoke", domain = "artichoke.run", include_apex = true, subdomains = ["rubyconf2019"] },
    { org = "artichoke", domain = "artichokeruby.org", include_apex = false, subdomains = ["www"] },
  ]
}

data "aws_route53_zone" "zone" {
  for_each = { for conf in local.pages : conf.domain => conf }
  name     = each.key
}


module "github_pages" {
  for_each = { for conf in local.pages : conf.domain => conf }
  source   = "../../../../../modules/github-pages-domain-dns"

  zone_id             = data.aws_route53_zone.zone[each.key].zone_id
  github_organization = each.value.org
  include_apex        = each.value.include_apex
  subdomains          = each.value.subdomains
}
