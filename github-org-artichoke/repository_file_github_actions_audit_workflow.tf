locals {
  // Set `force_bump_...` to true to create branches for PRs that update the
  // Audit workflow organization-wide.

  force_bump_audit_node = false
  audit_node_repos = [
    "clang-format",          // https://github.com/artichoke/clang-format
    "jasper",                // https://github.com/artichoke/jasper
    "logo",                  // https://github.com/artichoke/logo
    "spec-state",            // https://github.com/artichoke/spec-state
    "www.artichokeruby.org", // https://github.com/artichoke/www.artichokeruby.org
  ]

  force_bump_audit_ruby = false
  audit_ruby_repos = [
    "docker-artichoke-nightly", // https://github.com/artichoke/docker-artichoke-nightly
    "nightly",                  // https://github.com/artichoke/nightly
    "project-infrastructure",   // https://github.com/artichoke/project-infrastructure
  ]

  force_bump_audit_node_ruby = false
  audit_node_ruby_repos = [
    "artichoke.github.io", // https://github.com/artichoke/artichoke.github.io
    "rubyconf",            // https://github.com/artichoke/rubyconf
  ]

  force_bump_audit_ruby_rust = true
  audit_ruby_rust_repos = [
    "artichoke",             // https://github.com/artichoke/artichoke
    "boba",                  // https://github.com/artichoke/boba
    "cactusref",             // https://github.com/artichoke/cactusref
    "focaccia",              // https://github.com/artichoke/focaccia
    "intaglio",              // https://github.com/artichoke/intaglio
    "posix-space",           // https://github.com/artichoke/posix-space
    "qed",                   // https://github.com/artichoke/qed
    "rand_mt",               // https://github.com/artichoke/rand_mt
    "raw-parts",             // https://github.com/artichoke/raw-parts
    "roe",                   // https://github.com/artichoke/roe
    "ruby-file-expand-path", // https://github.com/artichoke/ruby-file-expand-path
    "strftime-ruby",         // https://github.com/artichoke/strftime-ruby
    "strudel",               // https://github.com/artichoke/strudel
  ]

  force_bump_audit_node_ruby_rust = true
  audit_node_ruby_rust_repos = [
    "playground", // https://github.com/artichoke/playground
  ]
}

module "audit_workflow_node" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_audit_node_ruby ? toset(local.audit_node_repos) : toset([])

  organization  = "artichoke"
  repository    = each.value
  base_branch   = "trunk"
  file_path     = ".github/workflows/audit.yaml"
  file_contents = file("${path.module}/templates/audit-workflow-node.yaml")
}

module "audit_workflow_ruby" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_audit_ruby ? toset(local.audit_ruby_repos) : toset([])

  organization  = "artichoke"
  repository    = each.value
  base_branch   = "trunk"
  file_path     = ".github/workflows/audit.yaml"
  file_contents = file("${path.module}/templates/audit-workflow-ruby.yaml")
}

module "audit_workflow_node_ruby" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_audit_node_ruby ? toset(local.audit_node_ruby_repos) : toset([])

  organization  = "artichoke"
  repository    = each.value
  base_branch   = "trunk"
  file_path     = ".github/workflows/audit.yaml"
  file_contents = file("${path.module}/templates/audit-workflow-node-ruby.yaml")
}

module "audit_workflow_ruby_rust" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_audit_ruby_rust ? toset(local.audit_ruby_rust_repos) : toset([])

  organization = "artichoke"
  repository   = each.value
  base_branch  = "trunk"
  file_path    = ".github/workflows/audit.yaml"

  file_contents = file("${path.module}/templates/audit-workflow-ruby-rust.yaml")
}

module "audit_workflow_node_ruby_rust" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_audit_node_ruby_rust ? toset(local.audit_node_ruby_rust_repos) : toset([])

  organization = "artichoke"
  repository   = each.value
  base_branch  = "trunk"
  file_path    = ".github/workflows/audit.yaml"

  file_contents = file("${path.module}/templates/audit-workflow-node-ruby-rust.yaml")
}
