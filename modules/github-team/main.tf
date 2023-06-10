resource "github_team" "this" {
  name        = var.name
  description = var.description

  # visible to all members of this organization.
  privacy = "closed"
}

resource "github_membership" "maintainer" {
  for_each = var.maintainers
  username = each.value
  role     = "admin"
}

resource "github_membership" "membership" {
  for_each = var.members
  username = each.value
  role     = "member"
}
