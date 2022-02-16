variable "github_token" {
  description = "GitHub Personal Access Token (PAT) with full access"
  type        = string
  sensitive   = true
}

variable "discord_git_events_webhook_id" {
  description = "Discord webhook id for #gitlog"
  type        = string
}

variable "discord_git_events_webhook_token" {
  description = "Discord webhook secret token for #gitlog"
  type        = string
  sensitive   = true
}

variable "discord_security_events_webhook_id" {
  description = "Discord webhook id for #security-events"
  type        = string
}

variable "discord_security_events_webhook_token" {
  description = "Discord webhook secret token for #security-events"
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
