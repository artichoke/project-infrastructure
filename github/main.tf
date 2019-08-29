variable "github_token" {}
variable "discord_api_secret" {}

provider "github" {
  version = "~> 2.2"

  token        = "${var.github_token}"
  organization = "artichoke"
}

resource "github_organization_webhook" "discord" {
  configuration {
    url          = "https://discordapp.com/api/webhooks/616536749367099402/${var.discord_api_secret}/github"
    content_type = "json"
    insecure_ssl = 0
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

module "jasper" {
  source = "./modules/repos/jasper"
}

module "project-infrastructure" {
  source = "./modules/repos/project-infrastructure"
}
