terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "aws/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

variable "name" {
  default = "artichoke-forge"
}

variable "github_actions_runners" {
  type = map(string)

  default = {
    project-infrastructure = "github-actions-repo-project-infrastructure"
  }
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

module "github_actions_project_infrastructure_assume_role" {
  source = "./modules/repository-assume-role"
}

output "github_actions_project_infrastructure_assume_role_arn" {
  value = module.github_actions_project_infrastructure_assume_role.role_arn
}

output "config" {
  value = <<CONFIG

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

output "github_actions_iam_access_ids" {
  value = module.github_actions_runner_read_only.access_ids
}

output "github_actions_iam_secret_keys" {
  value = module.github_actions_runner_read_only.secret_keys

  sensitive = true
}
