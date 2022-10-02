terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.3"
    }
  }
}

resource "github_organization_webhook" "discord" {
  configuration {
    url          = "https://discord.com/api/webhooks/${var.webhook_id}/${var.webhook_token}/github"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = toset(concat(var.github_events, ["meta"]))
}
