terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.10"
      configuration_aliases = [aws.us_east_1]
    }
  }

  required_version = "~> 1.0"
}
