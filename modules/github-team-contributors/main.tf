resource "github_team" "this" {
  name        = var.name
  description = var.description

  # only visible to organization owners and members of this team.
  privacy = "secret"
}

resource "github_team_members" "this" {
  team_id = github_team.this.id

  members {
    username = "lopopolo"
    role     = "maintainer"
  }

  members {
    username = "b-n"
    role     = "member"
  }
}
