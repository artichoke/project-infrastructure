data "terraform_remote_state" "aws" {
  backend = "s3"

  config = {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "aws/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"

    profile = "artichoke-forge-project-infrastructure"
  }
}

resource "github_actions_organization_secret" "terraform_aws_access_key" {
  secret_name     = "TF_AWS_ACCESS_KEY"
  visibility      = "selected"
  plaintext_value = data.terraform_remote_state.aws.outputs.github_actions_iam_access_ids["project-infrastructure"]

  selected_repository_ids = [github_repository.project_infrastructure.repo_id]
}

resource "github_actions_organization_secret" "terraform_aws_secret_key" {
  secret_name     = "TF_AWS_SECRET_KEY"
  visibility      = "selected"
  plaintext_value = data.terraform_remote_state.aws.outputs.github_actions_iam_secret_keys["project-infrastructure"]

  selected_repository_ids = [github_repository.project_infrastructure.repo_id]
}
