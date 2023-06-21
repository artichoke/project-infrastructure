# Google Site Verification

This folder contains a Terraform module to provision DNS records in an AWS
Route53 zone to verify a domain to a Google Service, for example Google Search
Console.

If setting verification keys for a Google Workspace property, see the
[`google-workspace`] module.

[`google-workspace`]: ../google-workspace

## Usage

```terraform
module "google_workspace" {
  source = "../modules/google-site-verification"

  zone_id = aws_route53_zone.this.zone_id

  site_verification_keys = [
    "abc...",
    "xyz...",
  ]
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create DNS records in.
- `site_verification_keys`: Google site verification keys for the apex domain.

## Outputs

This module has no outputs.
