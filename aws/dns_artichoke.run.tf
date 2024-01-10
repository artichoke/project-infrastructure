locals {
  artichoke_run_github_challenges = [
    { org = "artichoke", domain = "artichoke.run", challenge = "269dfad3e5" },
    { org = "artichoke", domain = "rubyconf2019.artichoke.run", challenge = "7334204bc9" },
    { org = "artichoke", domain = "www.artichoke.run", challenge = "cb003a6b0b" },
    { org = "artichokeruby", domain = "artichoke.run", challenge = "62c47d9852" },
    { org = "artichokeruby", domain = "rubyconf2019.artichoke.run", challenge = "45a5783abe" },
    { org = "artichokeruby", domain = "www.artichoke.run", challenge = "58c732d6b6" },
    { org = "artichoke-ruby-org", domain = "artichoke.run", challenge = "636dd41740" },
    { org = "artichoke-ruby-org", domain = "rubyconf2019.artichoke.run", challenge = "a5e31fdb89" },
    { org = "artichoke-ruby-org", domain = "www.artichoke.run", challenge = "0b0528b66d" },
  ]
}

resource "aws_route53_zone" "artichoke_run" {
  name = "artichoke.run"

  lifecycle {
    prevent_destroy = true
  }
}

module "artichoke_run_github_challenge" {
  source   = "../modules/github-domain-verification"
  for_each = { for conf in local.artichoke_run_github_challenges : "${conf.org}_${conf.domain}" => conf }

  zone_id             = aws_route53_zone.artichoke_run.zone_id
  github_organization = each.value.org
  domain              = each.value.domain
  challenge           = each.value.challenge
}

module "artichoke_run_github_pages_challenge" {
  source = "../modules/github-pages-domain-verification"

  zone_id             = aws_route53_zone.artichoke_run.zone_id
  github_organization = "artichoke"
  domain              = "artichoke.run"
  challenge           = "485977220be94c7ea6d333d5011d0c"
}

module "artichoke_run_github_pages" {
  source = "../modules/github-pages-domain-dns"

  zone_id             = aws_route53_zone.artichoke_run.zone_id
  github_organization = "artichoke"
}

module "rubyconf2019_artichoke_run_github_pages" {
  source = "../modules/github-pages-subdomain-dns"

  zone_id             = aws_route53_zone.artichoke_run.zone_id
  subdomain           = "rubyconf2019"
  github_organization = "artichoke"
}

module "artichoke_run_google" {
  source = "../modules/google-site-verification"

  zone_id = aws_route53_zone.artichoke_run.zone_id

  site_verification_keys = [
    "Ro-ABr2TIv3obx8csab8E3NC43BrANBdXimBKg2Jcxc", # Google Search Console
  ]
}
