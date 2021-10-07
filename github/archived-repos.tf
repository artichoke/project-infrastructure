#tfsec:ignore:github-repositories-vulnerability-alerts
resource "github_repository" "artichoke_ci" {
  name        = "artichoke-ci"
  description = "🏗 CI infrastructure and images for Artichoke"

  archived   = true
  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = true

  delete_branch_on_merge = false

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

#tfsec:ignore:github-repositories-vulnerability-alerts
resource "github_repository" "ferrocarril" {
  name         = "ferrocarril"
  description  = "🚆 Experiments to embed Ruby on Rails in Rust with mruby"
  homepage_url = "https://artichoke.github.io/ferrocarril/mruby/"

  archived   = true
  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = true

  delete_branch_on_merge = false

  topics = [
    "artichoke",
    "rack",
    "ruby",
    "rust",
    "sinatra",
    "unicorn",
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

#tfsec:ignore:github-repositories-vulnerability-alerts
resource "github_repository" "rust_mersenne_twister" {
  name         = "rust-mersenne-twister"
  description  = "Fork migrated to artichoke/rand_mt"
  homepage_url = "https://github.com/artichoke/rand_mt"

  archived   = true
  visibility = "public"

  has_downloads = true
  has_issues    = false
  has_projects  = false
  has_wiki      = true

  delete_branch_on_merge = true

  topics = []

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
