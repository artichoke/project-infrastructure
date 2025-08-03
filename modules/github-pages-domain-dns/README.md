# GitHub Pages Domain DNS

This folder contains a Terraform module to provision DNS records in an AWS
Route53 zone to setup GitHub pages for the `www` and apex domains in the given
zone.

## Usage

```terraform
module "artichokeruby_org_github_pages" {
  source = "../modules/github-pages-domain-dns"

  zone_id             = aws_route53_zone.this.zone_id
  github_organization = "artichoke"
}
```

## Parameters

- `include_apex`: Whether to create A and AAAA records for the apex domain.
  Defaults to `true`.
- `github_organization`: The GitHub organization slug, e.g. `artichoke`.
- `subdomains`: The list of subdomains to create CNAME records for. Defaults to
  `["www"]`.
- `zone_id`: The id of the Route53 zone to create TXT records in.

## Outputs

- `domains`: The list of FQDNs that records were created for.
