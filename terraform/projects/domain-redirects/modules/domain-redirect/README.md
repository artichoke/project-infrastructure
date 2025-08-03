# Domain Redirect

This folder contains a Terraform module to CloudFront distribution which will
redirect all requests for the given domain to another website, forwarding the
request path. This module will set DNS records at the given domain's apex and
www records.

This module is able to replicate the "domain forwarding" feature of Google
Domains.

## Usage

```terraform
module "access_logs" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-logs"
}

module "redirect" {
  source = "../modules/domain-redirect"

  access_logs_bucket = module.access_logs.name

  zone_id     = aws_route53_zone.this.zone_id
  redirect_to = "https://www.artichokeruby.org"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
```

## Parameters

- `access_logs_bucket`: The name of the bucket to use as an access logs
  destination.
- `zone_id`: The id of the Route53 zone to create redirect records in.
- `redirect_to`: The website to redirect to, should be of the format
  `https://example.com/`.
- `subdomains`: The set of subdomains to redirect. Defaults to `["www"]`.
- `include_apex`: Whether to include the apex domain in the given zone. Defaults
  to `true`.

## Outputs

- `bucket_arn`: The ARN of the created S3 bucket.
- `bucket_name`: The name of the created S3 bucket.
- `cert_arn`: The ARN of the created ACM certificate.
- `cloudfront_domain_name`: The domain name corresponding to the CloudFront
  distribution.
