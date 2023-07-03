# AWS ACM Certificate with DNS Validation

This folder contains a Terraform module to provision an ACM certificate using
DNS domain ownership verification in the provided Route53 zone.

## Usage

```terraform
module "cert" {
  source = "../modules/acm-cert-with-dns-validation"

  zone_id = aws_route53_zone.this.zone_id
  domains = ["artichokeruby.org", "www.artichokeruby.org"]

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create TXT records in.
- `domains`: The domains the certificate is valid for (SANs). The first domain
  in the list is the primary

## Outputs

- `cert_arn`: The ARN of the created ACM certificate.
