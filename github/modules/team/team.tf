variable "team" {
  type = string
}

variable "description" {
  type = string
}

variable "admins" {
  type = list(string)
}

variable "members" {
  type = list(string)
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
  count    = length(var.admins)
  team_id  = github_team.this.id
  username = element(var.admins, count.index)
  role     = "maintainer"
}

resource "github_team_membership" "members" {
  count    = length(var.members)
  team_id  = github_team.this.id
  username = element(var.members, count.index)
  role     = "member"
}
