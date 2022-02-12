terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "github/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

variable "github_token" {
  type      = string
  sensitive = true
}

variable "discord_api_secret" {
  type      = string
  sensitive = true
}

provider "github" {
  token = var.github_token
  owner = "artichoke"
}

resource "github_organization_webhook" "discord" {
  configuration {
    url          = "https://discordapp.com/api/webhooks/616536749367099402/${var.discord_api_secret}/github"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = [
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

module "org_members" {
  source = "../modules/github-organization-members"

  admins = toset([
    "lopopolo",
  ])

  members = toset([
    "artichoke-ci",
  ])
}

module "team_ci" {
  source = "../modules/github/team"

  team        = "ci"
  description = "Builds"

  admins = {
    lopopolo = "lopopolo"
  }

  members = {
    artichoke-ci = "artichoke-ci"
  }
}

module "team_cratesio_publishers" {
  source = "../modules/github/team"

  team        = "crates.io publishers"
  description = "Core team with perissions for publishing packages to crates.io"

  admins = {
    lopopolo = "lopopolo"
  }

  members = {}

  is_secret_team = false
}
