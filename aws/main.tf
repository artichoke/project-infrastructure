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
}

module "github_actions_oidc_provider" {
  source = "../modules/github-actions-oidc-provider"
}

module "github_actions_project_infrastructure_assume_role" {
  source = "../modules/github-actions-s3-bucket-read-only-access"

  github_oidc_provider_arn = module.github_actions_oidc_provider.arn
  github_organization      = "artichoke"
  github_repository        = "project-infrastructure"

  s3_bucket_name = "artichoke-forge-project-infrastructure-terraform-state"
}

module "repo_backups_access_logs" {
  source = "../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-github-backups-logs"
}

module "repo_backups" {
  source = "../modules/private-s3-bucket"

  bucket             = "artichoke-forge-github-backups"
  access_logs_bucket = module.repo_backups_access_logs.name
}

module "github_actions_s3_backups_assume_role" {
  source   = "../modules/github-actions-s3-repo-backup-access"
  for_each = toset(local.backed_up_repositories)

  github_oidc_provider_arn = module.github_actions_oidc_provider.arn
  github_organization      = "artichoke"
  github_repository        = each.value

  s3_bucket_name = module.repo_backups.name
}
