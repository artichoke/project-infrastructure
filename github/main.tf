variable "github_token" {}

provider "github" {
  version = "~> 2.2"

  token        = "${var.github_token}"
  organization = "artichoke"
}

resource "github_organization_webhook" "discord" {
  configuration {
    url          = "https://discordapp.com/api/webhooks/608192305341399041/oc9Q3GcyBwJwQz9YIMHg4g4ZL28JAEO7qdRKqVgQUkxXm0kXvvn2WbSspWNyX3TVz8-p/github"
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
