provider "aws" {
  region = var.region

  default_tags {
    tags = {
      environment = var.environment
      managed_by  = "terraform"
      project     = var.project
    }
  }
}
