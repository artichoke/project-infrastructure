# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "lib_ruby_parser" {
  name        = "lib-ruby-parser"
  description = "Artichoke fork of lib-ruby-parser, a Ruby parser written in Rust"

  visibility = "public"

  has_downloads = false
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "fork",
    "parser",
    "ruby",
    "rust",
    "vendor"
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_actions_repository_permissions" "lib_ruby_parser" {
  repository = github_repository.lib_ruby_parser.name
  enabled    = false
}

# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "mruby" {
  name        = "mruby"
  description = "Artichoke fork of mruby 3.x, a Lightweight Ruby"

  visibility = "public"

  has_downloads = false
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "embedded",
    "fork",
    "mruby",
    "ruby",
    "vendor"
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "mruby" {
  repository = github_repository.mruby.name
  branch     = "artichoke-vendor"
}

resource "github_actions_repository_permissions" "mruby" {
  repository = github_repository.mruby.name
  enabled    = false
}

# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "mspec" {
  name         = "mspec"
  description  = "Artichoke fork of MSpec, an RSpec-like test runner for the Ruby Spec Suite"
  homepage_url = "https://github.com/ruby/spec"

  visibility = "public"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "embedded",
    "fork",
    "ruby",
    "spec",
    "vendor",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "mspec" {
  repository = github_repository.mspec.name
  branch     = "artichoke-vendor"
}

resource "github_actions_repository_permissions" "mspec" {
  repository = github_repository.mspec.name
  enabled    = false
}

# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "onigmo" {
  name        = "Onigmo"
  description = "Artichoke fork of Onigmo, a regular expressions library forked from Oniguruma."

  visibility = "public"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "c",
    "fork",
    "regex",
    "regexp",
    "ruby",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_actions_repository_permissions" "onigmo" {
  repository = github_repository.onigmo.name
  enabled    = false
}

# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "oniguruma" {
  name        = "oniguruma"
  description = "Artichoke fork of oniguruma, a regular expression library"

  visibility = "public"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "c",
    "fork",
    "regex",
    "regexp",
    "ruby",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_actions_repository_permissions" "oniguruma" {
  repository = github_repository.oniguruma.name
  enabled    = false
}

# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "ruby" {
  name         = "ruby"
  description  = "Artichoke fork of Ruby 3.1.2"
  homepage_url = "https://www.ruby-lang.org/"

  visibility = "public"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "c",
    "embedded",
    "fork",
    "ruby",
    "vendor",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "ruby" {
  repository = github_repository.ruby.name
  branch     = "artichoke-vendor"
}

resource "github_actions_repository_permissions" "ruby" {
  repository = github_repository.ruby.name
  enabled    = false
}

# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "rust_onig" {
  name         = "rust-onig"
  description  = "Artichoke fork of rust-onig, Rust bindings for the Oniguruma regex library"
  homepage_url = "https://docs.rs/crate/onig/"

  visibility = "public"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "fork",
    "regex",
    "regexp",
    "ruby",
    "rust",
    "rust-crate",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "rust_onig" {
  repository = github_repository.rust_onig.name
  branch     = "artichoke-vendor"
}

resource "github_actions_repository_permissions" "rust_onig" {
  repository = github_repository.rust_onig.name
  enabled    = false
}

# tfsec:ignore:github-repositories-enable_vulnerability_alerts
resource "github_repository" "spec" {
  name        = "spec"
  description = "Artichoke fork of the Ruby Spec Suite aka ruby/spec"

  visibility = "public"

  has_downloads = false
  has_issues    = false
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = false

  topics = [
    "artichoke",
    "embedded",
    "fork",
    "ruby",
    "spec",
    "vendor",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_branch_default" "spec" {
  repository = github_repository.spec.name
  branch     = "artichoke-vendor"
}

resource "github_actions_repository_permissions" "spec" {
  repository = github_repository.spec.name
  enabled    = false
}
