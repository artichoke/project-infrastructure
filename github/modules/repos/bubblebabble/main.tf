locals {
  repository = "bubblebabble"
}

resource "github_repository" "this" {
  name         = local.repository
  description  = "💦 Rust implementation of the Bubble Babble binary data encoding"
  homepage_url = "https://artichoke.github.io/bubblebabble/bubblebabble"

  private = false

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

  topics = [
    "artichoke",
    "encoding",
    "decoding",
    "ruby",
    "rust",
    "rust-crate",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

module "colors" {
  source = "../../colors"
}

module "labels" {
  source     = "../../labels/common"
  repository = local.repository
}
