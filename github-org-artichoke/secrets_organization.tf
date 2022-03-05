resource "github_actions_organization_secret" "dockerhub_token" {
  secret_name     = "DOCKERHUB_TOKEN"
  visibility      = "selected"
  plaintext_value = var.dockerhub_token

  selected_repository_ids = [module.github_docker_artichoke_nightly.repo_id]
}

resource "github_actions_organization_secret" "dockerhub_user" {
  secret_name     = "DOCKERHUB_USER"
  visibility      = "selected"
  plaintext_value = var.dockerhub_user

  selected_repository_ids = [module.github_docker_artichoke_nightly.repo_id]
}
