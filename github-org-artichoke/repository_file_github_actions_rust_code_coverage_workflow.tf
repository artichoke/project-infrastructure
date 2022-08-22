locals {
  // Set `force_bump_s3_backup` to true to create branches for PRs that update
  // the S3 backup workflow organization-wide.

  force_bump_rust_code_coverage = false
  rust_code_coverage_repos = [
    "boba",          // https://github.com/artichoke/boba
    "focaccia",      // https://github.com/artichoke/focaccia
    "intaglio",      // https://github.com/artichoke/intaglio
    "posix-space",   // https://github.com/artichoke/posix-space
    "rand_mt",       // https://github.com/artichoke/rand_mt
    "raw-parts",     // https://github.com/artichoke/raw-parts
    "roe",           // https://github.com/artichoke/roe
    "strftime-ruby", // https://github.com/artichoke/strftime-ruby
    # "artichoke",   // https://github.com/artichoke/artichoke
    # "cactusref",   // https://github.com/artichoke/cactusref
    # "playground",  // https://github.com/artichoke/playground
    # "qed",         // https://github.com/artichoke/qed
    # "strudel",     // https://github.com/artichoke/strudel
  ]
}

module "rust_code_coverage_workflow" {
  source   = "../modules/update-github-repository-file"
  for_each = toset(local.force_bump_rust_code_coverage ? local.rust_code_coverage_repos : [])

  organization = "artichoke"
  repository   = each.value
  base_branch  = "trunk"
  file_path    = ".github/workflows/code-coverage.yaml"
  file_contents = templatefile(
    "${path.module}/templates/rust-code-coverage.yaml",
    {
      s3_bucket         = data.terraform_remote_state.aws.outputs.code_coverage_s3_bucket,
      backup_role_arn   = data.terraform_remote_state.aws.outputs.github_actions_code_coverage_assume_role_arn[each.value],
      github_repository = each.value,
    }
  )
}
