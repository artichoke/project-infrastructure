terraform {
  backend "s3" {
    bucket       = "artichoke-forge-project-infrastructure-terraform-state"
    region       = "us-west-2"
    key          = "aws-account-bootstrapping/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

import {
  to = module.aws_account_bootstrapping_global.aws_iam_account_password_policy.this
  id = "iam-account-password-policy"
}
