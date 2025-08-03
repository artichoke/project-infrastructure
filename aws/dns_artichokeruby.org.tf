locals {
  artichokeruby_org_github_challenges = [
    { org = "artichoke", domain = "artichokeruby.org", challenge = "c8065f2679" },
    { org = "artichoke", domain = "www.artichokeruby.org", challenge = "fdd9b51f12" },
    { org = "artichokeruby", domain = "artichokeruby.org", challenge = "e0a404f8a5" },
    { org = "artichokeruby", domain = "www.artichokeruby.org", challenge = "0aa1ad5148" },
    { org = "artichoke-ruby", domain = "artichokeruby.org", challenge = "f80b5a8055" },
    { org = "artichoke-ruby", domain = "www.artichokeruby.org", challenge = "4d9e15be0c" },
  ]
}

data "aws_route53_zone" "artichokeruby_org" {
  name = "artichokeruby.org"
}

module "artichokeruby_org_github_challenge" {
  source   = "../modules/github-domain-verification"
  for_each = { for conf in local.artichokeruby_org_github_challenges : "${conf.org}_${conf.domain}" => conf }

  zone_id             = data.aws_route53_zone.artichokeruby_org.zone_id
  github_organization = each.value.org
  domain              = each.value.domain
  challenge           = each.value.challenge
}

module "artichokeruby_org_github_pages_challenge" {
  source = "../modules/github-pages-domain-verification"

  zone_id             = data.aws_route53_zone.artichokeruby_org.zone_id
  github_organization = "artichoke"
  domain              = "artichokeruby.org"
  challenge           = "35fc238d3171df6cf54e3c2b07c195"
}

resource "aws_route53_record" "artichokeruby_org_codecov_ipv4" {
  zone_id = data.aws_route53_zone.artichokeruby_org.zone_id
  name    = "codecov.artichokeruby.org"
  type    = "A"

  alias {
    name                   = module.code_coverage.cloudfront_domain_name
    zone_id                = module.code_coverage.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "artichokeruby_org_codecov_ipv6" {
  zone_id = data.aws_route53_zone.artichokeruby_org.zone_id
  name    = "codecov.artichokeruby.org"
  type    = "AAAA"

  alias {
    name                   = module.code_coverage.cloudfront_domain_name
    zone_id                = module.code_coverage.cloudfront_zone_id
    evaluate_target_health = false
  }
}

module "artichokeruby_org_google_workspace" {
  source = "../modules/google-workspace"

  zone_id     = data.aws_route53_zone.artichokeruby_org.zone_id
  dkim_record = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAk3sMJuaFn/1lBZYWTc33CVQXtP8DAzP95vvwsN9V9iyU5Wyar7wUl514QSBzbDJgxF+VVfODy0KX/IcaelPsK67LxIfwk6HWVSfniUXbta5XPm5HTSFssNNoDuGRujdT3hFzecoMF/aWYR5TXjcM1ICt1U6kmfWB03quZXyZ0Y2YnaNGlv3hb+dWr58IZGuvA48TOmNVuFcQKsuz7sLOdkAA9AxCnDCkiMuV72SMbUq7Da0afLxObiYl9CN3J52qDp1qaxaGYU+2yie8+45IzihudYCEBuw8J8HXgRfcnqfmSscywlOPMk6HH8HYqZqPkKqd7mAmksWkDixY6rVMHQIDAQAB"

  site_verification_keys = [
    "WNbmzcJDc3Umb4SquyIhK5k-juY5IQj7RUe0ulAbrGY",
  ]
}
