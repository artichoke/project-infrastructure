module "remote_state_access_logs" {
  source = "../../../../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-project-infrastructure-terraform-state-logs"
}

module "remote_state" {
  source = "../../../../modules/private-s3-bucket"

  bucket             = "artichoke-forge-project-infrastructure-terraform-state"
  access_logs_bucket = module.remote_state_access_logs.name
}

# tfsec:ignore:aws-dynamodb-table-customer-key
resource "aws_dynamodb_table" "terraform_statelock" {
  name           = "terraform_statelock"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }
}
