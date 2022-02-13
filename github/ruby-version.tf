locals {
  force_bump_ruby_version = false

  // https://github.com/ruby/ruby/tree/v3_1_0
  ruby_version = "3.1.0"

  ruby_version_repos = [
    // Artichoke's `.ruby-version` file is not managed with Terraform because
    // Ruby version upgrade require extra (and manual) care.
    //
    // "artichoke",             // https://github.com/artichoke/artichoke
    "artichoke.github.io",      // https://github.com/artichoke/artichoke.github.io
    "boba",                     // https://github.com/artichoke/boba
    "cactusref",                // https://github.com/artichoke/cactusref
    "docker-artichoke-nightly", // https://github.com/artichoke/docker-artichoke-nightly
    "focaccia",                 // https://github.com/artichoke/focaccia
    "intaglio",                 // https://github.com/artichoke/intaglio
    "nightly",                  // https://github.com/artichoke/nightly
    "playground",               // https://github.com/artichoke/playground
    "project-infrastructure",   // https://github.com/artichoke/project-infrastructure
    "rand_mt",                  // https://github.com/artichoke/rand_mt
    "raw-parts",                // https://github.com/artichoke/raw-parts
    "roe",                      // https://github.com/artichoke/roe
    "rubyconf",                 // https://github.com/artichoke/rubyconf
    "ruby-file-expand-path",    // https://github.com/artichoke/ruby-file-expand-path
    "strudel",                  // https://github.com/artichoke/strudel
  ]
}

module "ruby_version" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_ruby_version ? toset(local.ruby_version_repos) : toset([])

  organization  = "artichoke"
  repository    = each.value
  base_branch   = "trunk"
  file_path     = ".ruby-version"
  file_contents = "${local.ruby_version}\n"
}

output "ruby_version_branches" {
  value = <<-HREFS

  ## Branch URLs:

  ${join(
  "\n",
  formatlist("- %s", [for repo, ruby_version in module.ruby_version : ruby_version.branch_href])
)}
  HREFS
}
