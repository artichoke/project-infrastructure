# GitHub Team – `crates.io publishers`

This folder contains a Terraform module to provision a "crates.io publishers"
GitHub team with [@lopopolo] as the only member.

[@lopopolo]: https://github.com/lopopolo

This team is used to grant ownership of crates on crates.io:
<https://crates.io/teams/github:artichoke:crates-io-publishers>.

## Usage

```terraform
module "team_crate_publishers" {
  source = "../modules/github-team-ci"

  team        = "crates.io publishers"
  description = "Core team with perissions for publishing packages to crates.io"
}
```

## Parameters

- `name`: The name of the GitHub team to create, defaults to
  `crates.io publishers`.
- `description`: The description of the team's purpose.

## Outputs

- `team_id`: The GitHub API id for the created team.
- `team_slug`: The URL-safe @-mentionable slug for the created team.
