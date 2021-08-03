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

variable "dockerhub_token" {
  type      = string
  sensitive = true
}

variable "dockerhub_user" {
  type      = string
  sensitive = true
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

resource "github_actions_organization_secret" "dockerhub_token" {
  secret_name     = "DOCKERHUB_TOKEN"
  visibility      = "selected"
  plaintext_value = var.dockerhub_token

  selected_repository_ids = [github_repository.docker_artichoke_nightly.repo_id]
}

resource "github_actions_organization_secret" "dockerhub_user" {
  secret_name     = "DOCKERHUB_USER"
  visibility      = "selected"
  plaintext_value = var.dockerhub_user

  selected_repository_ids = [github_repository.docker_artichoke_nightly.repo_id]
}
