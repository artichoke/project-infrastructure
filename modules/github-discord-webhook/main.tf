terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.20"
    }
  }
}

resource "github_organization_webhook" "discord" {
  configuration {
    url          = "https://discordapp.com/api/webhooks/${var.webhook_id}/${var.webhook_token}/github"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = var.events
}
