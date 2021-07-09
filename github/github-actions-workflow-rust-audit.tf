locals {
  // Set `cargo_deny_force_bump` to true to create branches for PRs that update
  // the `cargo-deny` version used in the `Audit` workflow.
  cargo_deny_force_bump = false
  // https://github.com/EmbarkStudios/cargo-deny/releases/tag/0.9.1
  cargo_deny_version = "0.9.1"
  rust_audit_repos = {
    artichoke  = "artichoke"  // https://github.com/artichoke/artichoke
    boba       = "boba"       // https://github.com/artichoke/boba
    boba       = "cactusref"  // https://github.com/artichoke/cactusref
    focaccia   = "focaccia"   // https://github.com/artichoke/focaccia
    intaglio   = "intaglio"   // https://github.com/artichoke/intaglio
    playground = "playground" // https://github.com/artichoke/playground
    rand_mt    = "rand_mt"    // https://github.com/artichoke/rand_mt
    roe        = "roe"        // https://github.com/artichoke/roe
    strudel    = "strudel"    // https://github.com/artichoke/strudel
  }
}

data "template_file" "github_actions_workflow_rust_audit" {
  template = file("${path.module}/files/workflows/rust-audit.yaml.tpl")
  vars = {
    cargo_deny_version = local.cargo_deny_version
  }
}

data "github_branch" "github_actions_workflow_rust_audit_sync_base" {
  for_each = local.rust_audit_repos

  repository = each.value
  branch     = "trunk"

  depends_on = [
    github_repository.artichoke,
    github_repository.boba,
    github_repository.cactusref,
    github_repository.focaccia,
    github_repository.intaglio,
    github_repository.playground,
    github_repository.rand_mt,
    github_repository.roe,
    github_repository.strudel,
  ]
}

resource "github_branch" "github_actions_workflows_rust_audit_pr_branch" {
  for_each = local.cargo_deny_force_bump ? local.rust_audit_repos : {}

  repository    = each.value
  branch        = "terraform/github_actions_workflows_sync_rust_audit"
  source_branch = "trunk"
  source_sha    = data.github_branch.github_actions_workflow_rust_audit_sync_base[each.key].sha
}

resource "github_repository_file" "github_actions_workflows_sync_rust_audit" {
  for_each = local.cargo_deny_force_bump ? local.rust_audit_repos : {}

  repository          = each.value
  branch              = "terraform/github_actions_workflows_sync_rust_audit"
  file                = ".github/workflows/audit.yaml"
  content             = data.template_file.github_actions_workflow_rust_audit.rendered
  commit_message      = "Update cargo-deny version to ${local.cargo_deny_version} in audit workflow\n\nManaged by Terraform"
  commit_author       = "artichoke-ci"
  commit_email        = "ci@artichokeruby.org"
  overwrite_on_create = true

  depends_on = [
    github_branch.github_actions_workflows_rust_audit_pr_branch["artichoke"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["boba"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["cactusref"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["focaccia"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["intaglio"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["playground"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["rand_mt"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["roe"],
    github_branch.github_actions_workflows_rust_audit_pr_branch["strudel"],
  ]
}

resource "github_repository_pull_request" "github_actions_workflow_rust_audit" {
  for_each = local.cargo_deny_force_bump ? local.rust_audit_repos : {}

  base_repository = each.value
  base_ref        = data.github_branch.github_actions_workflow_rust_audit_sync_base[each.key].ref
  head_ref        = github_branch.github_actions_workflows_rust_audit_pr_branch[each.key].ref
  title           = "Update cargo-deny version to ${local.cargo_deny_version} in audit workflow"
  body            = "Managed by terraform."

  maintainer_can_modify = true
}
