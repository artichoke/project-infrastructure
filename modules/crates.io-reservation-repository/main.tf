terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.3"
    }
  }
}

resource "github_repository" "this" {
  name         = var.repository
  description  = "📦 This repo was used to reserve the ${var.crate} crate on crates.io"
  homepage_url = "https://crates.io/crates/${var.crate}"

  visibility = "private"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  merge_commit_title          = "MERGE_MESSAGE"
  merge_commit_message        = "PR_TITLE"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  topics = [
    "artichoke",
    "reserve",
    "rust",
    "rust-crate",
  ]

  lifecycle {
    prevent_destroy = true
  }
}
