terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "aws/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

locals {
  backed_up_repositories = [
    "project-infrastructure",
  ]

  code_coverage_repositories = [
    "boba",          // https://github.com/artichoke/boba
    "focaccia",      // https://github.com/artichoke/focaccia
    "intaglio",      // https://github.com/artichoke/intaglio
    "posix-space",   // https://github.com/artichoke/posix-space
    "rand_mt",       // https://github.com/artichoke/rand_mt
    "raw-parts",     // https://github.com/artichoke/raw-parts
    "roe",           // https://github.com/artichoke/roe
    "strftime-ruby", // https://github.com/artichoke/strftime-ruby
    # "artichoke",   // https://github.com/artichoke/artichoke
    # "cactusref",   // https://github.com/artichoke/cactusref
    # "playground",  // https://github.com/artichoke/playground
    # "qed",         // https://github.com/artichoke/qed
    # "strudel",     // https://github.com/artichoke/strudel
  ]
}

data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

module "forge_access_logs" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-s3-logs-${var.region}"
}

# deprecated
module "repo_backups_access_logs" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-github-backups-logs-${var.region}"
}

module "repo_backups" {
  source = "../modules/private-archive-s3-bucket"

  bucket             = "artichoke-forge-github-backups-${var.region}"
  access_logs_bucket = module.forge_access_logs.name
}

module "github_actions_s3_backups_assume_role" {
  source   = "../modules/github-actions-s3-repo-backup-access"
  for_each = toset(local.backed_up_repositories)

  github_oidc_provider_arn = data.aws_iam_openid_connect_provider.github.arn
  github_organization      = "artichoke"
  github_repository        = each.value

  s3_bucket_name = module.repo_backups.name
}

module "code_coverage" {
  source = "../modules/s3-bucket-website-codecov"

  bucket             = "artichoke-forge-code-coverage-${var.region}"
  access_logs_bucket = module.forge_access_logs.name

  domains = ["codecov.artichokeruby.org"]

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}

module "github_actions_code_coverage_assume_role" {
  source   = "../modules/github-actions-s3-code-coverage-sync-access"
  for_each = toset(local.code_coverage_repositories)

  github_oidc_provider_arn = data.aws_iam_openid_connect_provider.github.arn
  github_organization      = "artichoke"
  github_repository        = each.value

  s3_bucket_name = module.code_coverage.name
}
