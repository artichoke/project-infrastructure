# Discord Webhook configuration docs
#
# https://discord.com/developers/docs/resources/webhook#webhook-object
# https://discord.com/developers/docs/topics/oauth2#webhooks

variable "webhook_id" {
  description = "Discord webhook id"
  type        = string
}

variable "webhook_token" {
  description = "Discord webhook secret token"
  type        = string
  sensitive   = true
}

# GitHub webhook event types docs
#
# https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads

variable "github_events" {
  description = "GitHub webhook events to subscribe to"
  type        = list(string)
}
