# GitHub Discord Webhook

This folder contains a Terraform module to provision a GitHub Organization
webhook that sends a configurable set of [webhook events] to a Discord channel.

[webhook events]:
  https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads

## Usage

```terraform
module "gitlog_webhook" {
  source = "../modules/github-discord-webhook"

  webhook_id    = var.discord_gitlog_webhook_id
  webhook_token = var.discord_gitlog_webhook_token

  github_events = [
    "commit_comment",
    "create",
    "delete",
    "discussion",
    "discussion_comment",
    "issue_comment",
    "issues",
    "public",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
    "release",
  ]
}
```

## Parameters

- `webhook_id`: The ID of the Discord webhook. For example, in the following
  webhook URL, the webhook ID is `347114750880120863`.

  ```
  https://discord.com/api/webhooks/347114750880120863/kKDdjXa1g9tKNs0-_yOwLyALC
  ```

- `webhook_token`: The token of the Discord webhook. For example, in the
  following webhook URL, the webhook token is `kKDdjXa1g9tKNs0-_yOwLyALC`.

  ```
  https://discord.com/api/webhooks/347114750880120863/kKDdjXa1g9tKNs0-_yOwLyALC
  ```

- `github_events`: A list of [webhook events] to send to this webhook.

## Outputs

This module has no outputs.
