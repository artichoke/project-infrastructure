# Google Workspace MX Records

This folder contains a Terraform module to provision MX records for a Google
Workspace domain in an AWS Route53 zone.

This module uses the "I signed up before 2023" configuration from the [Google
Workspace MX record values][workspace-mx] documentation, which provisions these
MX records:

| Name/Host/Alias | Priority | Value/Answer/Destination |
| --------------- | -------- | ------------------------ |
| Blank or @      | 1        | ASPMX.L.GOOGLE.COM       |
| Blank or @      | 5        | ALT1.ASPMX.L.GOOGLE.COM  |
| Blank or @      | 5        | ALT2.ASPMX.L.GOOGLE.COM  |
| Blank or @      | 10       | ALT3.ASPMX.L.GOOGLE.COM  |
| Blank or @      | 10       | ALT4.ASPMX.L.GOOGLE.COM  |

[workspace-mx]: https://support.google.com/a/answer/174125?hl=en&fl=1

## Usage

```terraform
module "mx" {
  source = "../modules/google-workspace-mx"

  zone_id = aws_route53_zone.this.zone_id
}
```

## Parameters

- `zone_id`: The id of the Route53 zone to create MX records in.

## Outputs

This module has no outputs.
