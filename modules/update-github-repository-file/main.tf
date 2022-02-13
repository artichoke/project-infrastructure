terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.20"
    }
  }
}

data "github_branch" "base" {
  repository = var.repository
  branch     = var.base_branch
}

resource "github_branch" "pr_target" {
  repository = var.repository
  branch     = "terraform/update-file-${replace(var.file_path, "/[ \\/]/", "-")}"
  source_sha = data.github_branch.base.sha
}

resource "github_repository_file" "file" {
  repository = var.repository
  branch     = github_branch.pr_target.ref
  file       = var.file_path
  content    = var.file_contents

  commit_message = <<-MESSAGE
  chore: Update `${var.file_path}` in `${var.organization}/${var.repository}`

  Managed by Terraform.

  ## Contents

  ```
  ${chomp(var.file_contents)}
  ```
  MESSAGE

  commit_author       = "artichoke-ci"
  commit_email        = "ci@artichokeruby.org"
  overwrite_on_create = true
}
