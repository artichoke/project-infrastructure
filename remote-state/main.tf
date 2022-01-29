terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "remote-state/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

resource "aws_s3_bucket" "this" {
  bucket = "artichoke-forge-project-infrastructure-terraform-state"
  acl    = "private"

  versioning {
    enabled    = true
    mfa_delete = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  logging {
    target_bucket = aws_s3_bucket.state_access_logs.id
    target_prefix = "v1/"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls   = true
  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true
}

resource "aws_s3_bucket" "state_access_logs" {
  bucket = "artichoke-forge-project-infrastructure-terraform-state-logs"
  acl    = "log-delivery-write"

  versioning {
    enabled    = true
    mfa_delete = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id      = "archive"
    enabled = true

    tags = {
      rule      = "archive"
      autoclean = "true"
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 90
    }

    noncurrent_version_transition {
      days          = 30
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 60
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "state_access_logs" {
  bucket = aws_s3_bucket.state_access_logs.id

  block_public_acls   = true
  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true
}

resource "aws_kms_key" "terraform_statelock" {
  enable_key_rotation = true
}

resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "terraform_statelock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.terraform_statelock.arn
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}
