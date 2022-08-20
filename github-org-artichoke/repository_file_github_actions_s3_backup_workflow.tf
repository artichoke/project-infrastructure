locals {
  // Set `force_bump_s3_backup` to true to create branches for PRs that update
  // the S3 backup workflow organization-wide.

  force_bump_s3_backup = false
  s3_backup_repos = [
    "project-infrastructure", // https://github.com/artichoke/project-infrastructure
  ]
}

resource "random_integer" "cron_day_of_month" {
  for_each = toset(local.s3_backup_repos)

  min = 1
  max = 25
}

module "s3_backup_workflow" {
  source   = "../modules/update-github-repository-file"
  for_each = toset(local.force_bump_s3_backup ? local.s3_backup_repos : [])

  organization = "artichoke"
  repository   = each.value
  base_branch  = "trunk"
  file_path    = ".github/workflows/s3-backup.yaml"
  file_contents = templatefile(
    "${path.module}/templates/s3-backup.yaml",
    {
      cron_day_of_month            = random_integer.cron_day_of_month[each.value].result,
      s3_bucket                    = data.terraform_remote_state.aws.outputs.github_actions_s3_backup_s3_bucket,
      backup_role_arn              = data.terraform_remote_state.aws.outputs.github_actions_s3_backup_assume_role_arn[each.value],
      github_repository            = each.value,
      python_github_backup_version = "0.40.1", // https://pypi.org/project/github-backup/
    }
  )
}
