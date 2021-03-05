locals {
  admins = {
    lopopolo = "lopopolo"
  }

  members = {
    artichoke-ci = "artichoke-ci"
  }
}

resource "github_membership" "admins" {
  for_each = local.admins

  username = each.value
  role     = "admin"
}

resource "github_membership" "members" {
  for_each = local.members

  username = each.value
  role     = "member"
}
