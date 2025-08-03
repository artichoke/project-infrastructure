locals {
  used_in_docs_buckets = [
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

  deprecated_buckets = [
    # These buckets were previously created by the domain redirect module, but
    # were retired since the module did not permit multiple redirects on a
    # single domain. They are now created by the reserved S3 buckets module.
    "artichoke-domain-redirect-artichoke-run",
    "artichoke-domain-redirect-artichokeruby-com",
    "artichoke-domain-redirect-artichokeruby-net",
    "artichoke-domain-redirect-artichokeruby-org",
    "artichoke-domain-redirect-artichokeruby-run",
    # These buckets were created in error by the domain redirect module with an
    # incorrect redirect target.
    "artichoke-domain-redirect-artichokeruby-com-afe91404",
    "artichoke-domain-redirect-artichokeruby-net-2859356e",
    "artichoke-domain-redirect-artichokeruby-org-6304d3c8",
  ]

  buckets = concat(
    local.used_in_docs_buckets,
    local.deprecated_buckets,
  )
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
