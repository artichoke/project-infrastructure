locals {
  artichokeruby_net_github_challenges = [
    { org = "artichoke", domain = "artichokeruby.net", challenge = "40284224b9" },
    { org = "artichoke", domain = "www.artichokeruby.net", challenge = "4970552f6c" },
    { org = "artichokeruby", domain = "artichokeruby.net", challenge = "7a2a1dc233" },
    { org = "artichokeruby", domain = "www.artichokeruby.net", challenge = "3113b923f8" },
    { org = "artichoke-ruby-org", domain = "artichokeruby.net", challenge = "98600a94a6" },
    { org = "artichoke-ruby-org", domain = "www.artichokeruby.net", challenge = "f82ad5d5e8" },
  ]
}

resource "aws_route53_zone" "artichokeruby_net" {
  name = "artichokeruby.net"

  lifecycle {
    prevent_destroy = true
  }
}

module "artichokeruby_net_github_challenge" {
  source   = "../modules/github-domain-verification"
  for_each = { for conf in local.artichokeruby_net_github_challenges : "${conf.org}_${conf.domain}" => conf }

  zone_id             = aws_route53_zone.artichokeruby_net.zone_id
  github_organization = each.value.org
  domain              = each.value.domain
  challenge           = each.value.challenge
}

module "artichokeruby_net_github_pages_challenge" {
  source = "../modules/github-pages-domain-verification"

  zone_id             = aws_route53_zone.artichokeruby_net.zone_id
  github_organization = "artichoke"
  domain              = "artichokeruby.net"
  challenge           = "7da729a45019ca339d0cedce912c2e"
}

module "artichokeruby_net_redirect" {
  source = "../modules/domain-redirect"

  access_logs_bucket = module.forge_access_logs.name

  zone_id     = aws_route53_zone.artichokeruby_net.zone_id
  redirect_to = "https://www.artichokeruby.org"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
