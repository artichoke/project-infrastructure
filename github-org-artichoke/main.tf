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

data "terraform_remote_state" "aws" {
  backend = "s3"

  config = {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "aws/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

resource "github_organization_settings" "this" {
  billing_email                                                = "github-billing@artichokeruby.org"
  blog                                                         = "https://www.artichokeruby.org"
  email                                                        = "github@artichokeruby.org"
  twitter_username                                             = "artichokeruby"
  name                                                         = "Artichoke Ruby"
  description                                                  = "Artichoke is a Ruby made with Rust"
  has_organization_projects                                    = false
  has_repository_projects                                      = false
  default_repository_permission                                = "read"
  members_can_create_repositories                              = true
  members_can_create_public_repositories                       = true
  members_can_create_private_repositories                      = true
  members_can_create_internal_repositories                     = false
  members_can_create_pages                                     = true
  members_can_create_public_pages                              = true
  members_can_create_private_pages                             = true
  members_can_fork_private_repositories                        = false
  web_commit_signoff_required                                  = false
  advanced_security_enabled_for_new_repositories               = false
  dependabot_alerts_enabled_for_new_repositories               = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = true
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
    "choznerol",
  ])
}

module "team_ci" {
  source = "../modules/github-team"

  name        = "ci"
  description = "Builds"

  maintainers = toset([
    "lopopolo",
  ])

  members = toset([
    "artichoke-ci",
  ])
}

module "team_contributors" {
  source = "../modules/github-team"

  name        = "contributors"
  description = "Code contributors"

  maintainers = toset([
    "lopopolo",
  ])

  members = toset([
    "b-n",
    "choznerol",
  ])
}

module "team_cratesio_publishers" {
  source = "../modules/github-team"

  name        = "crates.io publishers"
  description = "Core team with perissions for publishing packages to crates.io"

  maintainers = toset([
    "lopopolo",
  ])

  members = toset([])
}

resource "github_team_repository" "contributor_repos" {
  for_each = toset([
    "artichoke",
    "artichoke.github.io",
    "boba",
    "cactusref",
    "clang-format",
    "docker-artichoke-nightly",
    "focaccia",
    "generate_third_party",
    "intaglio",
    "jasper",
    "known-folders-rs",
    "logo",
    "mruby",
    "mspec",
    "nightly",
    "Onigmo",
    "oniguruma",
    "playground",
    "posix-space",
    "project-infrastructure",
    "python-github-backup",
    "qed",
    "rand_mt",
    "raw-parts",
    "roe",
    "ruby",
    "ruby-file-expand-path",
    "rubyconf",
    "rust-onig",
    "setup-rust",
    "spec",
    "spec-state",
    "strftime-ruby",
    "strudel",
    "sysdir-rs",
    "www.artichokeruby.org",
  ])

  team_id    = module.team_contributors.team_id
  repository = each.value
  permission = "push"
}

module "strftime_ruby_collaborators" {
  source = "../modules/github-repository-collaborators"

  repository = "strftime-ruby"
  collaborators = [
    { user = "x-hgg-x", role = "push" },
  ]
}
