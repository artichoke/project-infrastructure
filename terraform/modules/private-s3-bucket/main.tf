# Ensure the access logs bucket exists
data "aws_s3_bucket" "access_logs" {
  bucket = var.access_logs_bucket
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "archive"
    status = "Enabled"

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "GLACIER_IR"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_logging" "this" {
  bucket        = aws_s3_bucket.this.id
  target_bucket = data.aws_s3_bucket.access_logs.id
  target_prefix = "v2/${var.bucket}/"

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

  lifecycle {
    prevent_destroy = true
  }
}

# tfsec:ignore:aws-s3-encryption-customer-key
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status     = "Enabled"
    mfa_delete = "Disabled"
  }

  lifecycle {
    prevent_destroy = true
  }
}

data "aws_iam_policy_document" "deny_write_actions" {
  for_each = var.write_protected ? toset(["enabled"]) : toset([])

  statement {
    effect = "Deny"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:RestoreObject"
    ]

    resources = [
      "${aws_s3_bucket.this.arn}/*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "write_protection" {
  for_each = var.write_protected ? toset(["enabled"]) : toset([])

  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.deny_write_actions[each.value].json

  lifecycle {
    prevent_destroy = true
  }
}
