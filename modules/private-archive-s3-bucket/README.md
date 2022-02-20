# Private S3 Bucket

This folder contains a Terraform module to provision an AWS S3 bucket with no
public access and access logging enabled. This bucket has versioning and
lifecycle policies meant for long-term, append-only archival storage.

## Usage

```terraform
module "access_logs" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-backups-logs"
}

module "bucket" {
  source = "../modules/private-archive-s3-bucket"

  bucket = "artichoke-forge-backups"
  access_logs_bucket = module.access_logs.name
}
```

## Parameters

- `bucket`: The name of the bucket to create.
- `access_logs_bucket`: The name of the bucket to use as an access logs
  destination.

## Outputs

- `arn`: The ARN of the created bucket.
- `name`: The name of the created bucket.
