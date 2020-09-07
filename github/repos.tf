resource "github_repository" "boba" {
  name         = "boba"
  description  = "💦 Rust implementation of the Bubble Babble binary data encoding"
  homepage_url = "https://crates.io/crates/boba"

  private = false

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = true

  delete_branch_on_merge = true

  topics = [
    "artichoke",
    "bubblebabble",
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

resource "github_repository" "jasper" {
  name        = "jasper"
  description = "🧳 Single-binary packaging for Ruby applications that supports native and Wasm targets"

  private = false

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = true

  delete_branch_on_merge = true

  topics = [
    "artichoke",
    "bundler",
    "packaging",
    "ruby",
    "wasm",
    "webassembly",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "project_infrastructure" {
  name        = "project-infrastructure"
  description = "🛠 Infrastructure as code for the Artichoke open source project"

  private = false

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = true

  delete_branch_on_merge = true

  topics = [
    "artichoke",
    "infrastructure-as-code",
    "meta",
    "terraform",
  ]

  lifecycle {
    prevent_destroy = true
  }
}
