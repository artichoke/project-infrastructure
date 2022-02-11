variable "admins" {
  type = map(string)
}

variable "members" {
  type = map(string)
}

resource "github_membership" "admins" {
  for_each = var.admins

  username = each.value
  role     = "admin"
}

resource "github_membership" "members" {
  for_each = var.members

  username = each.value
  role     = "member"
}
