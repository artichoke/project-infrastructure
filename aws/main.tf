terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "aws/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"

    profile = "artichoke-forge-project-infrastructure"
  }
}

variable "name" {
  default = "artichoke-forge"
}

variable "iam_admins" {
  type = map(string)

  default = {
    lopopolo = "lopopolo"
  }
}

variable "github_actions_runners" {
  type = map(string)

  default = {
    project-infrastructure = "github-actions-repo-project-infrastructure"
  }
}

module "administrator_access" {
  source = "./modules/util/iam-admin"

  users = var.iam_admins
}

data "aws_iam_policy_document" "github_actions_runner_terraform_state_read_only" {
  statement {
    sid = 1

    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::artichoke-forge-project-infrastructure-terraform-state"]
  }

  statement {
    sid = 2

    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]
    resources = ["arn:aws:s3:::artichoke-forge-project-infrastructure-terraform-state/*"]
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
${join(
  "\n\n",
  formatlist(
    "%s",
    [for user in keys(module.administrator_access.users) :
      join("\n", [
        "  user: ${module.administrator_access.users[user]}",
        "    access id: ${module.administrator_access.access_ids[user]}",
        "    secret key: ${module.administrator_access.secret_keys[user]}"
      ])
    ]
  ))}

GitHub Actions IAM:
${join(
  "\n\n",
  formatlist(
    "%s",
    [for user in keys(module.github_actions_runner_read_only.users) :
      join("\n", [
        "  user: ${module.github_actions_runner_read_only.users[user]}",
        "    access id: ${module.github_actions_runner_read_only.access_ids[user]}",
        "    secret key: ${module.github_actions_runner_read_only.secret_keys[user]}"
      ])
    ]
))}

CONFIG

sensitive = true
}

output "iam_admin_users" {
  value = module.administrator_access.users
}

output "iam_admin_access_ids" {
  value = module.administrator_access.access_ids
}

output "iam_admin_secret_keys" {
  value = module.administrator_access.secret_keys

  sensitive = true
}

output "github_actions_iam_access_ids" {
  value = module.github_actions_runner_read_only.access_ids
}

output "github_actions_iam_secret_keys" {
  value = module.github_actions_runner_read_only.secret_keys

  sensitive = true
}
