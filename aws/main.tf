terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "aws/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

module "github_actions_project_infrastructure_assume_role" {
  source = "../modules/github-actions-s3-bucket-read-only-access"

  github_organization = "artichoke"
  github_repository   = "project-infrastructure"

  s3_bucket_name = "artichoke-forge-project-infrastructure-terraform-state"
}
