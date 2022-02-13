locals {
  // Set `force_bump_...` to true to create branches for PRs that update the
  // Audit workflow organization-wide.

  force_bump_audit_node = false
  audit_node_repos      = [
    "clang-format",          // https://github.com/artichoke/clang-format
    "jasper",                // https://github.com/artichoke/jasper
    "logo",                  // https://github.com/artichoke/logo
    "www.artichokeruby.org", // https://github.com/artichoke/www.artichokeruby.org
  ]

  force_bump_audit_ruby = false
  audit_ruby_repos      = [
    "docker-artichoke-nightly", // https://github.com/artichoke/docker-artichoke-nightly
    "nightly",                  // https://github.com/artichoke/nightly
    "project-infrastructure",   // https://github.com/artichoke/project-infrastructure
  ]

  force_bump_audit_node_ruby = false
  audit_node_ruby_repos      = [
    "artichoke.github.io", // https://github.com/artichoke/artichoke.github.io
    "playground",          // https://github.com/artichoke/playground
    "rubyconf",            // https://github.com/artichoke/rubyconf
  ]

  force_bump_audit_ruby_rust = false
  audit_ruby_rust_repos      = [
    "artichoke",             // https://github.com/artichoke/artichoke
    "boba",                  // https://github.com/artichoke/boba
    "cactusref",             // https://github.com/artichoke/cactusref
    "focaccia",              // https://github.com/artichoke/focaccia
    "intaglio",              // https://github.com/artichoke/intaglio
    "playground",            // https://github.com/artichoke/playground
    "rand_mt",               // https://github.com/artichoke/rand_mt
    "raw-parts",             // https://github.com/artichoke/raw-parts
    "roe",                   // https://github.com/artichoke/roe
    "ruby-file-expand-path", // https://github.com/artichoke/ruby-file-expand-path
    "strudel",               // https://github.com/artichoke/strudel
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

output "audit_workflow_node_branches" {
  value = <<-HREFS

  ## Branch URLs:

  ${join(
  "\n",
  formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_node : audit_workflow.branch_href])
)}
  HREFS
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

output "audit_workflow_node_ruby_branches" {
  value = <<-HREFS

  ## Branch URLs:

  ${join(
  "\n",
  formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_ruby : audit_workflow.branch_href])
)}
  HREFS
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

output "audit_workflow_node_ruby_branches" {
  value = <<-HREFS

  ## Branch URLs:

  ${join(
  "\n",
  formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_node_ruby : audit_workflow.branch_href])
)}
  HREFS
}

data "template_file" "audit_workflow_ruby_rust" {
  template = file("${path.module}/templates/audit-workflow-ruby-rust.yaml")

  vars = {
    // https://github.com/EmbarkStudios/cargo-deny/releases/tag/0.10.1
    cargo_deny_version = "0.10.1"
    release_base_url   = "https://github.com/EmbarkStudios/cargo-deny/releases/download"
  }
}

module "audit_workflow_ruby_rust" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_audit_ruby_rust ? toset(local.audit_ruby_rust_repos) : toset([])

  organization  = "artichoke"
  repository    = each.value
  base_branch   = "trunk"
  file_path     = ".github/workflows/audit.yaml"
  file_contents = data.template_file.audit_workflow_ruby_rust.rendered
}

output "audit_workflow_ruby_rust_branches" {
  value = <<-HREFS

  ## Branch URLs:

  ${join(
  "\n",
  formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_ruby_rust : audit_workflow.branch_href])
)}
  HREFS
}
