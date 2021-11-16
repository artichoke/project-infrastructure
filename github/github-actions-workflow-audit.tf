locals {
  // Set `force_bump` to true to create branches for PRs that update the Audit
  // workflow organization-wide.
  force_bump = false

  // https://github.com/EmbarkStudios/cargo-deny/releases/tag/0.9.1
  cargo_deny_version = "0.9.1"
  cargo_deny_audit_repos = {
    artichoke             = "artichoke"             // https://github.com/artichoke/artichoke
    boba                  = "boba"                  // https://github.com/artichoke/boba
    cactusref             = "cactusref"             // https://github.com/artichoke/cactusref
    focaccia              = "focaccia"              // https://github.com/artichoke/focaccia
    intaglio              = "intaglio"              // https://github.com/artichoke/intaglio
    playground            = "playground"            // https://github.com/artichoke/playground
    rand_mt               = "rand_mt"               // https://github.com/artichoke/rand_mt
    raw_parts             = "raw-parts"             // https://github.com/artichoke/raw-parts
    roe                   = "roe"                   // https://github.com/artichoke/roe
    ruby_file_expand_path = "ruby-file-expand-path" // https://github.com/artichoke/ruby-file-expand-path
    strudel               = "strudel"               // https://github.com/artichoke/strudel
  }

  npm_audit_repos = {
    artichoke_github_io    = "artichoke.github.io"    // https://github.com/artichoke/artichoke.github.io
    clang_format           = "clang-format"           // https://github.com/artichoke/clang-format
    jasper                 = "jasper"                 // https://github.com/artichoke/jasper
    logo                   = "logo"                   // https://github.com/artichoke/logo
    playground             = "playground"             // https://github.com/artichoke/playground
    project_infrastructure = "project-infrastructure" // https://github.com/artichoke/project-infrastructure
    rubyconf               = "rubyconf"               // https://github.com/artichoke/rubyconf
    www_artichokeruby_org  = "www.artichokeruby.org"  // https://github.com/artichoke/www.artichokeruby.org
  }

  bundler_audit_repos = {
    artichoke                = "artichoke"                // https://github.com/artichoke/artichoke
    artichoke_github_io      = "artichoke.github.io"      // https://github.com/artichoke/artichoke.github.io
    boba                     = "boba"                     // https://github.com/artichoke/boba
    cactusref                = "cactusref"                // https://github.com/artichoke/cactusref
    docker_artichoke_nightly = "docker-artichoke-nightly" // https://github.com/artichoke/docker-artichoke-nightly
    focaccia                 = "focaccia"                 // https://github.com/artichoke/focaccia
    intaglio                 = "intaglio"                 // https://github.com/artichoke/intaglio
    nightly                  = "nightly"                  // https://github.com/artichoke/nightly
    playground               = "playground"               // https://github.com/artichoke/playground
    project_infrastructure   = "project-infrastructure"   // https://github.com/artichoke/project-infrastructure
    rand_mt                  = "rand_mt"                  // https://github.com/artichoke/rand_mt
    raw_parts                = "raw-parts"                // https://github.com/artichoke/raw-parts
    roe                      = "roe"                      // https://github.com/artichoke/roe
    rubyconf                 = "rubyconf"                 // https://github.com/artichoke/rubyconf
    ruby_file_expand_path    = "ruby-file-expand-path"    // https://github.com/artichoke/ruby-file-expand-path
    strudel                  = "strudel"                  // https://github.com/artichoke/strudel
  }

  audit_managed_repos = {
    artichoke                = "artichoke"                // https://github.com/artichoke/artichoke
    artichoke_github_io      = "artichoke.github.io"      // https://github.com/artichoke/artichoke.github.io
    boba                     = "boba"                     // https://github.com/artichoke/boba
    cactusref                = "cactusref"                // https://github.com/artichoke/cactusref
    clang_format             = "clang-format"             // https://github.com/artichoke/clang-format
    docker_artichoke_nightly = "docker-artichoke-nightly" // https://github.com/artichoke/docker-artichoke-nightly
    focaccia                 = "focaccia"                 // https://github.com/artichoke/focaccia
    intaglio                 = "intaglio"                 // https://github.com/artichoke/intaglio
    jasper                   = "jasper"                   // https://github.com/artichoke/jasper
    logo                     = "logo"                     // https://github.com/artichoke/logo
    nightly                  = "nightly"                  // https://github.com/artichoke/nightly
    playground               = "playground"               // https://github.com/artichoke/playground
    project_infrastructure   = "project-infrastructure"   // https://github.com/artichoke/project-infrastructure
    rand_mt                  = "rand_mt"                  // https://github.com/artichoke/rand_mt
    raw_parts                = "raw-parts"                // https://github.com/artichoke/raw-parts
    roe                      = "roe"                      // https://github.com/artichoke/roe
    rubyconf                 = "rubyconf"                 // https://github.com/artichoke/rubyconf
    ruby_file_expand_path    = "ruby-file-expand-path"    // https://github.com/artichoke/ruby-file-expand-path
    strudel                  = "strudel"                  // https://github.com/artichoke/strudel
    www_artichokeruby_org    = "www.artichokeruby.org"    // https://github.com/artichoke/www.artichokeruby.org
  }
}

data "template_file" "github_actions_workflows_audit" {
  for_each = local.audit_managed_repos

  template = file("${path.module}/files/workflows/audit.yaml.tpl")
  vars = {
    cargo_deny_version = local.cargo_deny_version
    has_cargo_deny     = lookup(local.cargo_deny_audit_repos, each.key, "n/a") == each.value
    has_npm_audit      = lookup(local.npm_audit_repos, each.key, "n/a") == each.value
    has_bundler_audit  = lookup(local.bundler_audit_repos, each.key, "n/a") == each.value
  }
}

data "github_branch" "github_actions_workflows_audit_base" {
  for_each = local.audit_managed_repos

  repository = each.value
  branch     = "trunk"

  depends_on = [
    github_repository.artichoke,
    github_repository.artichoke_github_io,
    github_repository.boba,
    github_repository.cactusref,
    github_repository.clang_format,
    github_repository.docker_artichoke_nightly,
    github_repository.focaccia,
    github_repository.intaglio,
    github_repository.jasper,
    github_repository.logo,
    github_repository.nightly,
    github_repository.playground,
    github_repository.project_infrastructure,
    github_repository.rand_mt,
    github_repository.roe,
    github_repository.rubyconf,
    github_repository.ruby_file_expand_path,
    github_repository.strudel,
    github_repository.www_artichokeruby_org,
  ]
}

resource "github_branch" "github_actions_workflows_audit" {
  for_each = local.force_bump ? local.audit_managed_repos : {}

  repository    = each.value
  branch        = "terraform/github_actions_workflows_audit"
  source_branch = "trunk"
  source_sha    = data.github_branch.github_actions_workflows_audit_base[each.key].sha
}

resource "github_repository_file" "github_actions_workflows_audit" {
  for_each = local.force_bump ? local.audit_managed_repos : {}

  repository          = each.value
  branch              = github_branch.github_actions_workflows_audit[each.key].ref
  file                = ".github/workflows/audit.yaml"
  content             = data.template_file.github_actions_workflows_audit[each.key].rendered
  commit_message      = <<-MESSAGE
    Update Audit GitHub Actions workflow

    Managed by Terraform.

    The cargo-deny version is ${local.cargo_deny_version}.
  MESSAGE
  commit_author       = "artichoke-ci"
  commit_email        = "ci@artichokeruby.org"
  overwrite_on_create = true
}

resource "github_repository_pull_request" "github_actions_workflow_audit" {
  for_each = local.force_bump ? local.audit_managed_repos : {}

  base_repository = each.value
  base_ref        = data.github_branch.github_actions_workflows_audit_base[each.key].ref
  head_ref        = github_branch.github_actions_workflows_audit[each.key].ref
  title           = "Update Audit GitHub Actions workflow"
  body            = <<-BODY
    Managed by Terraform.

    The cargo-deny version is ${local.cargo_deny_version}.

    Pushed commit ${github_repository_file.github_actions_workflows_audit[each.key].commit_sha}.
  BODY

  maintainer_can_modify = true
}

output "github_actions_workflows_audit_pull_requests" {
  value = <<-CONFIG
    Pull Requests:
    ${local.force_bump ? join(
  "\n",
  formatlist(
    "%s",
    [for slug, repo in local.audit_managed_repos :
      join("/", [
        "https://github.com/artichoke",
        repo,
        "pull",
        github_repository_pull_request.github_actions_workflow_audit[slug].number,
      ])
    ]
)) : "none"}
  CONFIG
}
