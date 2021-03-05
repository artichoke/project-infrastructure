resource "github_repository" "artichoke_ci" {
  name         = "artichoke-ci"
  description  = "🏗 Archived CI infrastructure and images for Artichoke, migrated to GitHub Actions"
  homepage_url = "https://github.com/artichoke/artichoke/tree/trunk/.github/workflows"

  archived   = true
  visibility = "public"

  has_downloads = false
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true

  topics = [
    "artichoke",
    "base-image",
    "build",
    "ci",
    "circleci",
    "docker",
    "dockerfile",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "cactusref" {
  name         = "cactusref"
  description  = "🌵 Archived experimental cycle-aware reference counting crate"
  homepage_url = "https://artichoke.github.io/cactusref/cactusref/"

  archived   = true
  visibility = "public"

  has_downloads = false
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true

  topics = [
    "artichoke",
    "garbage-collection",
    "garbage-collector",
    "gc",
    "memory-management",
    "reference-counting",
    "rust",
    "rust-crate",
    "smart-pointer",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "ferrocarril" {
  name         = "ferrocarril"
  description  = "🚆 Archived experiments to embed Ruby on Rails in Rust with mruby, migrated to artichoke/artichoke repository"
  homepage_url = "https://www.artichokeruby.org/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true

  topics = [
    "artichoke",
    "language",
    "programming-language",
    "ruby",
    "ruby-language",
    "rust",
    "rust-application",
    "rust-crate",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "rust_mersenne_twister" {
  name         = "rust-mersenne-twister"
  description  = "Archived fork of mersenne-twister crate, migrated to artichoke/rand_mt repository"
  homepage_url = "https://github.com/artichoke/rand_mt"

  archived   = true
  visibility = "public"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true

  topics = [
    "archived",
    "artichoke",
    "mersenne-twister",
    "rand",
    "random",
    "rng",
    "rust",
    "rust-crate",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
