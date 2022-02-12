variable "github_token" {
  description = "GitHub Personal Access Token (PAT) with full access"
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

