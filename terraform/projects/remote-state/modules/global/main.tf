module "remote_state_access_logs" {
  source = "../../../../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-project-infrastructure-terraform-state-logs"
}

module "remote_state" {
  source = "../../../../modules/private-s3-bucket"

  bucket             = "artichoke-forge-project-infrastructure-terraform-state"
  access_logs_bucket = module.remote_state_access_logs.name
}
