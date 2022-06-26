terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "github/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

provider "github" {
  token = var.github_token
  owner = "artichoke"
}

module "git_events_webhook" {
  source = "../modules/github-discord-webhook"

  webhook_id    = var.discord_git_events_webhook_id
  webhook_token = var.discord_git_events_webhook_token

  # https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads
  github_events = [
    "commit_comment",
    "create",
    "delete",
    "issues",
    "issue_comment",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
  ]
}

module "security_events_webhook" {
  source = "../modules/github-discord-webhook"

  webhook_id    = var.discord_security_events_webhook_id
  webhook_token = var.discord_security_events_webhook_token

  # https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads
  github_events = [
    "branch_protection_rule",
    "code_scanning_alert",
    "deploy_key",
    "member",
    "membership",
    "organization",
    "org_block",
    "public",
    "repository",
    "repository_import",
    "repository_vulnerability_alert",
    "secret_scanning_alert",
    "team",
    "team_add",
  ]
}

module "org_members" {
  source = "../modules/github-organization-members"

  admins = toset([
    "lopopolo",
  ])

  members = toset([
    "artichoke-ci",
    "b-n",
  ])
}

module "team_ci" {
  source = "../modules/github-team-ci"

  name        = "ci"
  description = "Builds"
}

module "team_contributors" {
  source = "../modules/github-team-contributors"

  name        = "contributors"
  description = "Code contributors"
}

module "team_cratesio_publishers" {
  source = "../modules/github-team-crates.io-publishers"

  name        = "crates.io publishers"
  description = "Core team with perissions for publishing packages to crates.io"
}

resource "github_team_repository" "contributor_repos" {
  for_each = toset([
    "artichoke",
    "boba",
    "cactusref",
    "clang-format",
    "focaccia",
    "intaglio",
    "jasper",
    "playground",
    "qed",
    "rand_mt",
    "raw-parts",
    "roe",
    "ruby-file-expand-path",
    "strftime-ruby",
    "strudel",
  ])

  team_id    = module.team_contributors.team_id
  repository = each.value
  permission = "push"
}
