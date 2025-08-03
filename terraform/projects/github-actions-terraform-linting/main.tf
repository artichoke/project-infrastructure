terraform {
  backend "s3" {
    bucket       = "artichoke-forge-project-infrastructure-terraform-state"
    region       = "us-west-2"
    key          = "github-actions-terraform-linting/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
