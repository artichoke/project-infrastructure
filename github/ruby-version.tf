locals {
  // Set `ruby_version_force_bump` to true to create branches for PRs that
  // update the `.ruby-version` version used in each repository.
  ruby_version_force_bump = false
  // https://github.com/ruby/ruby/tree/v3_0_2
  ruby_version = "3.0.2"
  ruby_version_repos = {
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
    roe                      = "roe"                      // https://github.com/artichoke/roe
    rubyconf                 = "rubyconf"                 // https://github.com/artichoke/rubyconf
    strudel                  = "strudel"                  // https://github.com/artichoke/strudel
  }
}

data "template_file" "ruby_version" {
  template = file("${path.module}/files/ruby-version.tpl")
  vars = {
    ruby_version = local.ruby_version
  }
}

data "github_branch" "ruby_version_sync_base" {
  for_each = local.ruby_version_repos

  repository = each.value
  branch     = "trunk"

  depends_on = [
    github_repository.artichoke,
    github_repository.artichoke_github_io,
    github_repository.boba,
    github_repository.cactusref,
    github_repository.focaccia,
    github_repository.intaglio,
    github_repository.playground,
    github_repository.project_infrastructure,
    github_repository.rand_mt,
    github_repository.roe,
    github_repository.rubyconf,
    github_repository.strudel,
  ]
}

resource "github_branch" "ruby_version_pr_branch" {
  for_each = local.ruby_version_force_bump ? local.ruby_version_repos : {}

  repository    = each.value
  branch        = "terraform/ruby_version_bump"
  source_branch = "trunk"
  source_sha    = data.github_branch.ruby_version_sync_base[each.key].sha
}

resource "github_repository_file" "ruby_version" {
  for_each = local.ruby_version_force_bump ? local.ruby_version_repos : {}

  repository          = each.value
  branch              = "terraform/ruby_version_bump"
  file                = ".ruby-version"
  content             = data.template_file.ruby_version.rendered
  commit_message      = "Update Ruby toolchain version to ${local.ruby_version} in .ruby-version\n\nManaged by Terraform"
  commit_author       = "artichoke-ci"
  commit_email        = "ci@artichokeruby.org"
  overwrite_on_create = true

  depends_on = [
    github_branch.ruby_version_pr_branch["artichoke"],
    github_branch.ruby_version_pr_branch["artichoke_github_io"],
    github_branch.ruby_version_pr_branch["boba"],
    github_branch.ruby_version_pr_branch["cactusref"],
    github_branch.ruby_version_pr_branch["focaccia"],
    github_branch.ruby_version_pr_branch["intaglio"],
    github_branch.ruby_version_pr_branch["playground"],
    github_branch.ruby_version_pr_branch["project_infrastructure"],
    github_branch.ruby_version_pr_branch["rand_mt"],
    github_branch.ruby_version_pr_branch["roe"],
    github_branch.ruby_version_pr_branch["rubyconf"],
    github_branch.ruby_version_pr_branch["strudel"],
  ]
}

resource "github_repository_pull_request" "ruby_version" {
  for_each = local.ruby_version_force_bump ? local.ruby_version_repos : {}

  base_repository = each.value
  base_ref        = data.github_branch.ruby_version_sync_base[each.key].ref
  head_ref        = github_branch.ruby_version_pr_branch[each.key].ref
  title           = "Update Ruby toolchain version to ${local.ruby_version} in .ruby-version"
  body            = "Managed by terraform."

  maintainer_can_modify = true

  depends_on = [
    github_repository_file.ruby_version["artichoke"],
    github_repository_file.ruby_version["artichoke_github_io"],
    github_repository_file.ruby_version["boba"],
    github_repository_file.ruby_version["cactusref"],
    github_repository_file.ruby_version["focaccia"],
    github_repository_file.ruby_version["intaglio"],
    github_repository_file.ruby_version["playground"],
    github_repository_file.ruby_version["project_infrastructure"],
    github_repository_file.ruby_version["rand_mt"],
    github_repository_file.ruby_version["roe"],
    github_repository_file.ruby_version["rubyconf"],
    github_repository_file.ruby_version["strudel"],
  ]
}

output "ruby_version_pull_requests" {
  value = <<CONFIG

Pull Requests:
${local.ruby_version_force_bump ? join(
  "\n",
  formatlist(
    "%s",
    [for repo in keys(local.ruby_version_repos) :
      join("/", [
        "https://github.com/artichoke",
        local.ruby_version_repos[repo],
        "pull",
        github_repository_pull_request.ruby_version[repo].number,
      ])
    ]
)) : "none"}

CONFIG
}
