terraform {
  backend "s3" {
    bucket         = "artichoke-terraform-state"
    region         = "us-west-2"
    key            = "aws/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"

    profile = "artichokeruby"
  }
}


variable "name" {
  default = "artichokeruby"
}

variable "iam_admins" {
  default = ["lopopolo"]
}

variable "github_actions_runners" {
  default = ["github-actions-repo-project-infrastructure"]
}

data "aws_iam_policy_document" "admin" {
  statement {
    sid = 1

    effect = "Allow"

    actions   = ["*"]
    resources = ["*"]
  }
}

module "iam_admin" {
  source = "./modules/util/iam"

  name  = "${var.name}-admin"
  users = var.iam_admins

  policy = data.aws_iam_policy_document.admin.json
}

data "aws_iam_policy_document" "github_actions_runner_terraform_state_read_only" {
  statement {
    sid = 1

    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::artichoke-terraform-state"]
  }

  statement {
    sid = 2

    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]
    resources = ["arn:aws:s3:::artichoke-terraform-state/*"]
  }
}

module "github_actions_runner_read_only" {
  source = "./modules/util/iam"

  name  = "${var.name}-github-actions-readonly"
  users = var.github_actions_runners

  policy = data.aws_iam_policy_document.github_actions_runner_terraform_state_read_only.json
}

output "config" {
  value = <<CONFIG

Admin IAM:
  Admin Users: ${join(
  "\n               ",
  formatlist("%s", module.iam_admin.users),
  )}

  Access IDs: ${join(
  "\n              ",
  formatlist("%s", module.iam_admin.access_ids),
  )}

  Secret Keys: ${join(
  "\n               ",
  formatlist("%s", module.iam_admin.secret_keys),
  )}

GitHub Actions IAM:
  Admin Users: ${join(
  "\n               ",
  formatlist("%s", module.github_actions_runner_read_only.users),
  )}

  Access IDs: ${join(
  "\n              ",
  formatlist("%s", module.github_actions_runner_read_only.access_ids),
  )}

  Secret Keys: ${join(
  "\n               ",
  formatlist("%s", module.github_actions_runner_read_only.secret_keys),
)}

CONFIG

}

output "iam_admin_users" {
  value = module.iam_admin.users
}

output "iam_admin_access_ids" {
  value = module.iam_admin.access_ids
}

output "iam_admin_secret_keys" {
  value = module.iam_admin.secret_keys
}
