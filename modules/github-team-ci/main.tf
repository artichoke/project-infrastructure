resource "github_team" "this" {
  name        = var.name
  description = var.description

  # visible to all members of this organization.
  privacy = "closed"
}

resource "github_team_members" "this" {
  team_id = github_team.this.id

  members {
    username = "lopopolo"
    role     = "maintainer"
  }

  members {
    username = "artichoke-ci"
    role     = "member"
  }
}
