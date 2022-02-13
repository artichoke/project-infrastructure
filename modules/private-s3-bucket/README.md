# Private S3 Bucket

This folder contains a Terraform module to provision an AWS S3 bucket with no public access
and access logs.

## Usage

```terraform
module "bucket" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-project-infrastructure-terraform-state-logs"
  access_logs_bucket = module.access_logs.name
}
```

## Parameters

- `bucket`: The name of the bucket to create.
- `access_logs_bucket`: The name of the bucket to use as an access logs destination.

## Outputs

- `arn`: The ARN of the created bucket.
- `name`: The name of the created bucket.
