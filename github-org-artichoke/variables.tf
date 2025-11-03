variable "github_token" {
  description = "GitHub Personal Access Token (PAT) with full access"
  type        = string
  sensitive   = true
}

variable "dockerhub_user" {
  description = "Docker Hub user for pushing container images in CI"
  type        = string
  sensitive   = true
}

variable "dockerhub_token" {
  description = "Docker Hub access token for the given Docker Hub user"
  type        = string
  sensitive   = true
}
