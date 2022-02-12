terraform {
  backend "s3" {
    bucket         = "artichoke-forge-project-infrastructure-terraform-state"
    region         = "us-west-2"
    key            = "github-org-artichokeruby/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "terraform_statelock"
  }
}

module "security_events_webhook" {
  source = "../modules/github-discord-webhook"

  webhook_id    = var.discord_security_events_webhook_id
  webhook_token = var.discord_security_events_webhook_token

  # https://docs.github.com/en/developers/webhooks-and-events/webhooks/webhook-events-and-payloads
  github_events = [
    "branch_protection_rule",
    "code_scanning_alert",
    "deploy_key",
    "member",
    "membership",
    "organization",
    "org_block",
    "public",
    "repository",
    "repository_import",
    "repository_vulnerability_alert",
    "secret_scanning_alert",
    "team",
    "team_add",
  ]
}

module "org_members" {
  source = "../modules/github-organization-members"

  admins = toset([
    "lopopolo",
  ])

  members = toset([
    "artichoke-ci",
  ])
}
