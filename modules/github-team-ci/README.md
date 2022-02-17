# GitHub Team – `ci`

This folder contains a Terraform module to provision a "ci" GitHub team with
[@lopopolo] and [@artichoke-ci] as members.

[@lopopolo]: https://github.com/lopopolo
[@artichoke-ci]: https://github.com/artichoke-ci

## Usage

```terraform
module "team_ci" {
  source = "../modules/github-team-ci"

  team        = "ci"
  description = "Builds"
}
```

## Parameters

- `name`: The name of the GitHub team to create, defaults to `ci`.
- `description`: The description of the team's purpose.

## Outputs

- `team_id`: The GitHub API id for the created team.
- `team_slug`: The URL-safe @-mentionable slug for the created team.
