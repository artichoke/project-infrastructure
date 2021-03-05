locals {
  crate_reservations = {
    artichoke      = "artichoke-reserve"
    artichokeruby  = "artichokeruby-reserve"
    artichoke-ruby = "artichoke-ruby-reserve"
    boba           = "boba-reserve"
    invokedynamic  = "invokedynamic-reserve"
  }
}

resource "github_repository" "private_crate_reservation" {
  for_each = local.crate_reservations

  name         = each.value
  description  = format("📦 This repo was used to reserve the %s crate on crates.io", each.key)
  homepage_url = format("https://crates.io/crates/%s", each.key)

  visibility = "private"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true

  topics = [
    "artichoke",
    "reserve",
    "rust",
    "rust-crate",
  ]

  lifecycle {
    prevent_destroy = true
  }
}
