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

module "github_actions_project_infrastructure_assume_role" {
  source = "../modules/aws/repository-assume-role"
}

output "github_actions_project_infrastructure_assume_role_arn" {
  value = module.github_actions_project_infrastructure_assume_role.role_arn
}
