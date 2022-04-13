locals {
  // Set `force_bump_...` to true to create branches for PRs that update the
  // rustdoc Documentation workflow organization-wide.

  force_bump_rustdoc = false
  rustdoc_repos = [
    // artichoke has custom bits that are manually managed.
    // playground does not deploy rustdoc to GitHub Pages.

    "boba",                  // https://github.com/artichoke/boba
    "cactusref",             // https://github.com/artichoke/cactusref
    "focaccia",              // https://github.com/artichoke/focaccia
    "intaglio",              // https://github.com/artichoke/intaglio
    "qed",                   // https://github.com/artichoke/qed
    "rand_mt",               // https://github.com/artichoke/rand_mt
    "raw-parts",             // https://github.com/artichoke/raw-parts
    "roe",                   // https://github.com/artichoke/roe
    "ruby-file-expand-path", // https://github.com/artichoke/ruby-file-expand-path
    "strudel",               // https://github.com/artichoke/strudel
  ]
}

module "rustdoc_workflow" {
  source   = "../modules/update-github-repository-file"
  for_each = local.force_bump_rustdoc ? toset(local.rustdoc_repos) : toset([])

  organization  = "artichoke"
  repository    = each.value
  base_branch   = "trunk"
  file_path     = ".github/workflows/rustdoc.yaml"
  file_contents = file("${path.module}/templates/rustdoc-workflow.yaml")
}
