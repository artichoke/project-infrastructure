terraform {
  backend "s3" {
    bucket       = "artichoke-forge-project-infrastructure-terraform-state"
    region       = "us-west-2"
    key          = "artichokeruby-domain-redirects/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}
