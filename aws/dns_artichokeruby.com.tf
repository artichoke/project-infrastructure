locals {
  artichokeruby_com_github_challenges = [
    { org = "artichoke", domain = "artichokeruby.com", challenge = "b2f4638e51" },
    { org = "artichoke", domain = "www.artichokeruby.com", challenge = "2fec52406f" },
    { org = "artichokeruby", domain = "artichokeruby.com", challenge = "ca289d9cc6" },
    { org = "artichokeruby", domain = "www.artichokeruby.com", challenge = "4ed7a6a51e" },
    { org = "artichoke-ruby-org", domain = "artichokeruby.com", challenge = "52fff25586" },
    { org = "artichoke-ruby-org", domain = "www.artichokeruby.com", challenge = "2f65a1a84d" },
  ]
}

resource "aws_route53_zone" "artichokeruby_com" {
  name = "artichokeruby.com"

  lifecycle {
    prevent_destroy = true
  }
}

module "artichokeruby_com_github_challenge" {
  source   = "../modules/github-domain-verification"
  for_each = { for conf in local.artichokeruby_com_github_challenges : "${conf.org}_${conf.domain}" => conf }

  zone_id             = aws_route53_zone.artichokeruby_com.zone_id
  github_organization = each.value.org
  domain              = each.value.domain
  challenge           = each.value.challenge
}

module "artichokeruby_com_github_pages_challenge" {
  source = "../modules/github-pages-domain-verification"

  zone_id             = aws_route53_zone.artichokeruby_com.zone_id
  github_organization = "artichoke"
  domain              = "artichokeruby.com"
  challenge           = "cef8b209bccd79f7df0f51b877bd9e"
}

module "artichokeruby_com_redirect" {
  source = "../modules/domain-redirect"

  access_logs_bucket = module.forge_access_logs.name

  zone_id     = aws_route53_zone.artichokeruby_com.zone_id
  redirect_to = "https://www.artichokeruby.org"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
