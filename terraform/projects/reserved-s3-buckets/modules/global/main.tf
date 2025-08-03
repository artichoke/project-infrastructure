locals {
  buckets = [
    "artichoke-forge-backups",
    "artichoke-forge-backups-logs",
    "artichoke-forge-code-coverage",
    "artichoke-forge-logs",
    # Despite not being present in this repository, these buckets have already
    # been created and the S3 API reports they are owned by the Artichoke Forge
    # account.
    #
    # "artichoke-forge-project-infrastructure-terraform-state",
    # "artichoke-forge-project-infrastructure-terraform-state-logs",
  ]
}

module "reserved_s3_buckets_access_logs" {
  source = "../../../../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-reserved-buckets-logs"
}

module "reserved_s3_bucket" {
  for_each = toset(local.buckets)
  source   = "../../../../modules/private-s3-bucket"

  bucket             = each.value
  access_logs_bucket = module.reserved_s3_buckets_access_logs.name
}
