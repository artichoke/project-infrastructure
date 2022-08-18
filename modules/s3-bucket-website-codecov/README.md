# S3 Bucket Website `codecov`

This folder contains a Terraform module to provision an AWS S3 bucket with no
public access that is made accessible via CloudFront for
`codecov.artichokeruby.org`.

## Usage

```terraform
module "access_logs" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-logs"
}

module "code_coverage" {
  source = "../modules/s3-bucket-website"

  bucket             = "artichoke-forge-code-coverage"
  access_logs_bucket = module.access_logs.name

  domains = ["codecov.artichokeruby.org"]

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
```

## Parameters

- `bucket`: The name of the bucket to create.
- `access_logs_bucket`: The name of the bucket to use as an access logs
  destination.
- `domains`: List of domain names included in the ACM certificate and CloudFront
  distribution.

## Outputs

- `arn`: The ARN of the created bucket.
- `name`: The name of the created bucket.
- `cert_arn`: The ARN of the created ACM certificate.
- `cloudfront_domain_name`: The domain name corresponding to the CloudFront
  distribution.
