variable "dockerhub_token" {
  type      = string
  sensitive = true
}

variable "dockerhub_user" {
  type      = string
  sensitive = true
}

resource "github_actions_organization_secret" "dockerhub_token" {
  secret_name     = "DOCKERHUB_TOKEN"
  visibility      = "selected"
  plaintext_value = var.dockerhub_token

  selected_repository_ids = [github_repository.docker_artichoke_nightly.repo_id]
}

resource "github_actions_organization_secret" "dockerhub_user" {
  secret_name     = "DOCKERHUB_USER"
  visibility      = "selected"
  plaintext_value = var.dockerhub_user

  selected_repository_ids = [github_repository.docker_artichoke_nightly.repo_id]
}
