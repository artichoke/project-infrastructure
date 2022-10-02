terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.3"
    }
  }
}

resource "github_repository_collaborator" "collaborators" {
  for_each = { for config in var.collaborators : config.user => config.role }

  repository = var.repository
  username   = each.key
  permission = each.value
}
