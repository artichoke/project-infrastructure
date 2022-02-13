# `artichoke-ruby` GitHub Organization Terraform Environment

This is a [Terraform] configuration for the [@artichoke-ruby] GitHub
organization. It manages organization memberships, teams, and repositories.

[terraform]: https://www.terraform.io
[@artichoke-ruby]: https://github.com/artichoke-ruby

## Variables

This environment requires several variables to be set:

- `github_token`: A [github access token] with at least `repo`, `admin:org`,
  `admin:org_hook`, and `workflow` scopes.
- `discord_security_events_webhook_id`: A Discord webhook id for delivering
  security audit events.
- `discord_security_events_webhook_token`: A Discord webhook token for
  delivering security audit events.

[github access token]:
  https://github.com/settings/tokens/new?scopes=repo,admin:org,admin:org_hook,workflow
