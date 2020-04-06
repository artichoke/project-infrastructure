resource "github_membership" "membership_lopopolo" {
  username = "lopopolo"
  role     = "admin"
}

resource "github_membership" "membership_artichoke_ci" {
  username = "artichoke-ci"
  role     = "member"
}
