resource "github_team" "ci" {
  name        = "ci"
  description = "Builds"
  privacy     = "secret"
}

resource "github_team_membership" "ci_lopopolo_membership" {
  team_id  = github_team.ci.id
  username = "lopopolo"
  role     = "maintainer"
}

resource "github_team_membership" "ci_artichoke_ci_membership" {
  team_id  = github_team.ci.id
  username = "artichoke-ci"
  role     = "member"
}
