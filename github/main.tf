terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "github/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"

    profile = "artichoke-forge-project-infrastructure"
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

provider "github" {
  token = var.github_token
  owner = "artichokeruby"

  alias = "artichokeruby"
}

provider "github" {
  token = var.github_token
  owner = "artichoke-ruby"

  alias = "artichoke_ruby"
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

module "artichoke_users" {
  source = "./modules/users"

  admins = {
    lopopolo = "lopopolo"
  }

  members = {
    artichoke-ci = "artichoke-ci"
  }
}

module "team_ci" {
  source = "./modules/team"

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
  source = "./modules/team"

  team        = "crates.io publishers"
  description = "Core team with perissions for publishing packages to crates.io"

  admins = {
    lopopolo = "lopopolo"
  }

  members = {}

  is_secret_team = false
}

// Secondary organizations

module "artichokeruby_users" {
  source = "./modules/users"
  providers = {
    github = github.artichokeruby
  }

  admins = {
    lopopolo = "lopopolo"
  }

  members = {
    artichoke-ci = "artichoke-ci"
  }
}

module "artichoke_ruby_users" {
  source = "./modules/users"
  providers = {
    github = github.artichoke_ruby
  }

  admins = {
    lopopolo = "lopopolo"
  }

  members = {
    artichoke-ci = "artichoke-ci"
  }
}
