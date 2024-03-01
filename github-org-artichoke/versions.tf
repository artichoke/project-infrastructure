terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
  required_version = "~> 1.0"
}
