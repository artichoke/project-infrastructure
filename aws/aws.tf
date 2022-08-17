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

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  default_tags {
    tags = {
      environment = var.environment
      managed_by  = "terraform"
      project     = var.project
    }
  }
}
