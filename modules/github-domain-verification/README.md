# GitHub Domain Verification

This folder contains a Terraform module to provision a TXT record that verifies
ownership of a domain for a GitHub organization.

## Usage

```terraform
module "github_challenge" {
  source = "../modules/github-domain-verification"

  zone_id             = aws_route53_zone.this.zone_id
  github_organization = "artichoke"
  domain              = "artichokeruby.org"
  challenge           = "xxxxx"
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create DKIM records in.
- `github_organization`: The GitHub organization slug, e.g. `artichoke`.
- `domain`: The domain to verify.
- `challenge`: Challenge token.

## Outputs

This module has no outputs.
