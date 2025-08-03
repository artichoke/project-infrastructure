terraform {
  backend "s3" {
    bucket       = "artichoke-forge-project-infrastructure-terraform-state"
    region       = "us-west-2"
    key          = "route53-dns/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
