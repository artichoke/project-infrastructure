locals {
  project_website_redirect_domains = [
    { domain = "artichokeruby.com", redirect_to = "https://www.artichokeruby.org", include_apex = true, subdomains = ["www"] },
    { domain = "artichokeruby.net", redirect_to = "https://www.artichokeruby.org", include_apex = true, subdomains = ["www"] },
    { domain = "artichokeruby.org", redirect_to = "https://www.artichokeruby.org", include_apex = true, subdomains = [] },
  ]

  codecov_redirect_domains = [
    { domain = "artichoke.run", redirect_to = "https://codecov.artichokeruby.org", include_apex = false, subdomains = ["codecov"] },
    { domain = "artichokeruby.com", redirect_to = "https://codecov.artichokeruby.org", include_apex = false, subdomains = ["codecov"] },
    { domain = "artichokeruby.net", redirect_to = "https://codecov.artichokeruby.org", include_apex = false, subdomains = ["codecov"] },
    { domain = "artichokeruby.run", redirect_to = "https://codecov.artichokeruby.org", include_apex = false, subdomains = ["codecov"] },
  ]

  playground_redirect_domains = [
    { domain = "artichokeruby.com", redirect_to = "https://artichoke.run", include_apex = false, subdomains = ["play"] },
    { domain = "artichokeruby.net", redirect_to = "https://artichoke.run", include_apex = false, subdomains = ["play"] },
    { domain = "artichokeruby.org", redirect_to = "https://artichoke.run", include_apex = false, subdomains = ["play"] },
    { domain = "artichokeruby.run", redirect_to = "https://artichoke.run", include_apex = true, subdomains = ["play", "www"] },
    { domain = "artichoke.run", redirect_to = "https://artichoke.run", include_apex = false, subdomains = ["play", "www"] },
  ]

  domain_redirects = concat(
    local.project_website_redirect_domains,
    local.codecov_redirect_domains,
    local.playground_redirect_domains,
  )
}

data "aws_route53_zone" "zone" {
  for_each = toset([for conf in local.domain_redirects : conf.domain])
  name     = each.key
}

module "redirect_bucket_access_logs" {
  source = "../../../../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-redirect-bucket-logs"
}

module "domain_redirect" {
  for_each = { for conf in local.domain_redirects : substr(md5("${conf.domain}-redirect-to-${conf.redirect_to}"), 0, 8) => conf }
  source   = "../../../../../modules/domain-redirect"

  access_logs_bucket = module.redirect_bucket_access_logs.name
  zone_id            = data.aws_route53_zone.zone[each.value.domain].zone_id
  redirect_to        = each.value.redirect_to
  include_apex       = each.value.include_apex
  subdomains         = each.value.subdomains
  suffix             = each.key

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
