# Google Workspace

This folder contains a Terraform module to provision DNS records in an AWS
Route53 zone to setup email for a Google Workspace domain.

## Usage

```terraform
module "google_workspace" {
  source = "../modules/google-workspace"

  zone_id     = aws_route53_zone.this.zone_id
  dkim_record = "v=DKIM1; k=rsa; p=..."

  site_verification_keys = [
    "abc...",
    "xyz...",
  ]
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create DNS records in.
- `dkim_record`: The full value of the DKIM TXT record.
- `site_verification_keys`: Google site verification keys for the apex domain.

## Outputs

This module has no outputs.
