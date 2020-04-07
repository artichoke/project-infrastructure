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
  default = "lopopolo"
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

output "config" {
  value = <<CONFIG

Admin IAM:
  Admin Users: ${join(
  "\n               ",
  formatlist("%s", split(",", module.iam_admin.users)),
  )}

  Access IDs: ${join(
  "\n              ",
  formatlist("%s", split(",", module.iam_admin.access_ids)),
  )}

  Secret Keys: ${join(
  "\n               ",
  formatlist("%s", split(",", module.iam_admin.secret_keys)),
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
