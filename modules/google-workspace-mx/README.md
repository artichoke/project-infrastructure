# Google Workspace MX Records

This folder contains a Terraform module to provision MX records for a Google
Workspace domain in an AWS Route53 zone.

## Usage

```terraform
module "mx" {
  source = "../modules/google-workspace-mx"

  zone_id = aws_route53_zone.this.zone_id
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create DKIM records in.

## Outputs

This module has no outputs.
