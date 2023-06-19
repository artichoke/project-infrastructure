# Google Workspace DKIM TXT Record

This folder contains a Terraform module to provision an DKIM TXT record in an
AWS Route53 zone.

## Usage

```terraform
module "dkim" {
  source = "../modules/google-workspace-dkim"

  zone_id     = aws_route53_zone.this.zone_id
  dkim_record = "v=DKIM1; k=rsa; p=..."
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create DKIM records in.
- `dkim_record`: The full value of the DKIM TXT record.

## Outputs

This module has no outputs.
