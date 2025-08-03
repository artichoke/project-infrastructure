locals {
  artichokeruby_run_github_challenges = [
    { org = "artichoke", domain = "artichokeruby.run", challenge = "8c1ebf9fc6" },
    { org = "artichoke", domain = "www.artichokeruby.run", challenge = "f8dd1ad8a9" },
    { org = "artichokeruby-org", domain = "artichokeruby.run", challenge = "d99613e00f" },
    { org = "artichokeruby-org", domain = "www.artichokeruby.run", challenge = "6554401e36" },
    { org = "artichoke-ruby-org", domain = "artichokeruby.run", challenge = "5d7d7290b9" },
    { org = "artichoke-ruby-org", domain = "www.artichokeruby.run", challenge = "3e5409f8a9" },
  ]
}

data "aws_route53_zone" "artichokeruby_run" {
  name = "artichokeruby.run"
}

module "artichokeruby_run_github_challenge" {
  source   = "../modules/github-domain-verification"
  for_each = { for conf in local.artichokeruby_run_github_challenges : "${conf.org}_${conf.domain}" => conf }

  zone_id             = data.aws_route53_zone.artichokeruby_run.zone_id
  github_organization = each.value.org
  domain              = each.value.domain
  challenge           = each.value.challenge
}

module "artichokeruby_run_github_pages_challenge" {
  source = "../modules/github-pages-domain-verification"

  zone_id             = data.aws_route53_zone.artichokeruby_run.zone_id
  github_organization = "artichoke"
  domain              = "artichokeruby.run"
  challenge           = "50369d1a13ec11c0d9899705388810"
}
