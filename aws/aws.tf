variable "region" {
  default = "us-west-2"
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      project    = "aws"
      managed_by = "terraform"
    }
  }
}
