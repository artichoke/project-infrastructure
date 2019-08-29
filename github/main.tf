variable "github_token" {}

provider "github" {
  version = "~> 2.2"

  token        = "${var.github_token}"
  organization = "artichoke"
}
