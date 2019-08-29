locals {
  repository = "project-infrastructure"
}

resource "github_repository" "project-infrastructure" {
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
}
