locals {
  force_bump_ruby_version = false

  // https://github.com/ruby/ruby/tree/v3_2_2
  ruby_version = "3.2.2"

  ruby_version_repos = [
    "artichoke",                // https://github.com/artichoke/artichoke
    "boba",                     // https://github.com/artichoke/boba
    "cactusref",                // https://github.com/artichoke/cactusref
    "docker-artichoke-nightly", // https://github.com/artichoke/docker-artichoke-nightly
    "focaccia",                 // https://github.com/artichoke/focaccia
    "generate_third_party",     // https://github.com/artichoke/generate_third_party
    "intaglio",                 // https://github.com/artichoke/intaglio
    "known-folders-rs",         // https://github.com/artichoke/known-folders-rs
    "nightly",                  // https://github.com/artichoke/nightly
    "playground",               // https://github.com/artichoke/playground
    "posix-space",              // https://github.com/artichoke/posix-space
    "project-infrastructure",   // https://github.com/artichoke/project-infrastructure
    "qed",                      // https://github.com/artichoke/qed
    "rand_mt",                  // https://github.com/artichoke/rand_mt
    "raw-parts",                // https://github.com/artichoke/raw-parts
    "roe",                      // https://github.com/artichoke/roe
    "rubyconf",                 // https://github.com/artichoke/rubyconf
    "ruby-file-expand-path",    // https://github.com/artichoke/ruby-file-expand-path
    "setup-rust",               // https://github.com/artichoke/setup-rust
    "strftime-ruby",            // https://github.com/artichoke/strftime-ruby
    "strudel",                  // https://github.com/artichoke/strudel
    "sysdir-rs",                // https://github.com/artichoke/sysdir-rs
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
