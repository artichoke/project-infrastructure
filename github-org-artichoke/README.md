# `artichoke` GitHub Organization Terraform Environment

This is a [Terraform] configuration for the [@artichoke] GitHub organization. It
manages organization memberships, teams, and repositories.

[terraform]: https://www.terraform.io
[@artichoke]: https://github.com/artichoke

This configuration also includes modules that can be used to create PRs across
the organization for shared configuration files that must be kept in sync for
all repositories.

## Variables

This environment requires several variables to be set:

- `github_token`: A [github access token] with at least `repo`, `admin:org`,
  `admin:org_hook`, and `workflow` scopes.
- `discord_git_events_webhook_id`: A Discord webhook id for delivering git audit
  events.
- `discord_git_events_webhook_token`: A Discord webhook token for delivering git
  audit events.
- `discord_security_events_webhook_id`: A Discord webhook id for delivering
  security audit events.
- `discord_security_events_webhook_token`: A Discord webhook token for
  delivering security audit events.
- `dockerhub_user`: A Docker Hub user for pushing container images in GitHub
  Actions workflows.
- `dockerhub_token`: A Docker Hub access token for the given Docker Hub user.

[github access token]:
  https://github.com/settings/tokens/new?scopes=repo,admin:org,admin:org_hook,workflow
