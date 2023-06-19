# GitHub Pages Subdomain DNS

This folder contains a Terraform module to provision DNS records in an AWS
Route53 zone to setup GitHub pages for the given subdomain.

## Usage

```terraform
module "codecov_artichokeruby_org_github_pages" {
  source = "../modules/github-pages-domain-dns"

  zone_id             = aws_route53_zone.this.zone_id
  subdomain           = "codecov"
  github_organization = "artichoke"
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create DKIM records in.
- `subdomain`: The subdomain to setup GitHub Pages on.
- `github_organization`: The GitHub organization slug, e.g. `artichoke`.

## Outputs

This module has no outputs.
