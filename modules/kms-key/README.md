# KMS Key

This folder contains a Terraform module to provision an AWS KMS key with key
rotation and an alias.

## Usage

```terraform
module "remote_state" {
  source = "../modules/kms-key"

  description       = "Key for encrypting remote state bucket contents"
  alias_name_prefix = "s3-remote-state-"
}
```

## Parameters

- `description`: The description of the KMS key.
- `alias_name_prefix`: A prefix for the alias name. This variable must be
  non-empty and must not start with `alias/`.

## Outputs

- `key_arn`: The ARN of the created KMS key.
- `key_id`: The ID of the created KMS key.
- `alias_arn`: The ARN of the created KMS key alias.
- `alias_name`: The name of the created KMS key alias.
