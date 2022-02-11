variable "team" {
  type = string
}

variable "description" {
  type = string
}

variable "admins" {
  type = map(string)
}

variable "members" {
  type = map(string)
}

variable "is_secret_team" {
  type    = bool
  default = true
}

resource "github_team" "this" {
  name        = var.team
  description = var.description
  privacy     = var.is_secret_team ? "secret" : "closed"
}

resource "github_team_membership" "admins" {
  for_each = var.admins

  team_id  = github_team.this.id
  username = each.value
  role     = "maintainer"
}

resource "github_team_membership" "members" {
  for_each = var.members

  team_id  = github_team.this.id
  username = each.value
  role     = "member"
}
