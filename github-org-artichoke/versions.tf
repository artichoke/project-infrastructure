terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.9"
    }
  }
  required_version = "~> 1.0"
}
