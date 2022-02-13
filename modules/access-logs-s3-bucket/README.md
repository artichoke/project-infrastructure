# Access Logs S3 Bucket

This folder contains a Terraform module to provision an AWS S3 bucket with the
`log-delivery-write` which is appropriate to use as a destination for access
logs of other S3 buckets.

## Usage

```terraform
module "access_logs" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-project-infrastructure-terraform-state-logs"
}
```

## Parameters

- `bucket`: The name of the bucket to create.

## Outputs

- `arn`: The ARN of the created bucket.
- `name`: The name of the created bucket.
