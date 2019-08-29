locals {
  repository = "project-infrastructure"
}

resource "github_repository" "this" {
  name        = local.repository
  description = "🛠 Infrastructure as code for the Artichoke open source project"

  private = false

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

  topics = [
    "artichoke",
    "infrastructure-as-code",
    "terraform",
    "meta",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

module "colors" {
  source = "../../colors"
}

module "labels" {
  source     = "../../labels/common"
  repository = local.repository
}

resource "github_issue_label" "area_aws" {
  repository = local.repository
  name = "A-aws"
  description = "Area: AWS infrastructure as code."

  color = module.colors.area
}

resource "github_issue_label" "area_dns" {
  repository = local.repository
  name = "A-dns"
  description = "Area: DNS configuration."

  color = module.colors.area
}

resource "github_issue_label" "area_github" {
  repository = local.repository
  name = "A-github"
  description = "Area: GitHub infrastructure as code."

  color = module.colors.area
}

resource "github_issue_label" "area_google_domains" {
  repository = local.repository
  name = "A-google-domains"
  description = "Area: Google Domains infrastructure as code."

  color = module.colors.area
}
