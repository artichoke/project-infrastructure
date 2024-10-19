terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "github-actions-oidc-provider/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}
