terraform {
  backend "s3" {
    bucket         = "artichoke-terraform-state"
    region         = "us-west-2"
    key            = "github/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"

    profile = "artichokeruby"
  }
}

variable "github_token" {
  type = string
}

variable "discord_api_secret" {
  type = string
}

provider "github" {
  version = "~> 2.3"

  token        = var.github_token
  organization = "artichoke"
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

module "team_ci" {
  source = "./modules/team"

  team        = "ci"
  description = "Builds"
  admins      = ["lopopolo"]
  members     = ["artichoke-ci"]
}
