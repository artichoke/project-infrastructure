terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.20"
    }
  }
}

resource "github_repository" "this" {
  name         = var.name
  description  = var.description
  homepage_url = var.homepage_url

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  merge_commit_title          = "MERGE_MESSAGE"
  merge_commit_message        = "PR_TITLE"
  squash_merge_commit_title   = "PR_TITLE"
  squash_merge_commit_message = "PR_BODY"

  topics = toset(concat(var.topics, ["artichoke"]))

  dynamic "pages" {
    for_each = range(var.has_github_pages ? 1 : 0)

    content {
      cname = var.github_pages_cname

      source {
        branch = "gh-pages"
        path   = "/"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
