# GitHub Team – `contributors`

This folder contains a Terraform module to provision a "contributors" GitHub
team with human users who contribute to the [@artichoke] organization.

[@artichoke]: https://github.com/artichoke

## Usage

```terraform
module "team_contributors" {
  source = "../modules/github-team-contributors"

  name        = "contributors"
  description = "Code contributors"
}
```

## Parameters

- `name`: The name of the GitHub team to create, defaults to `contributors`.
- `description`: The description of the team's purpose.

## Outputs

- `team_id`: The GitHub API id for the created team.
- `team_slug`: The URL-safe @-mentionable slug for the created team.
