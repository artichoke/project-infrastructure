variable "region" {
  default = "us-west-2"
}

provider "aws" {
  region  = var.region
  profile = "artichoke-forge-project-infrastructure"

  default_tags {
    tags = {
      project    = "remote-state"
      managed_by = "terraform"
    }
  }
}
