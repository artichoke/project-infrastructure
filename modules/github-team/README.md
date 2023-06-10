# GitHub Team

This folder contains a Terraform module to provision a GitHub team with users
who contribute to the [@artichoke] organization.

[@artichoke]: https://github.com/artichoke

## Usage

```terraform
module "team_contributors" {
  source = "../modules/github-team"

  name        = "contributors"
  description = "Code contributors"
  maintainers = set(["lopopolo"])
  members     = set(["..."])
}
```

## Parameters

- `name`: The name of the GitHub team to create.
- `description`: The description of the team's purpose.
- `maintainers`: The maintainers of the team as a set of GitHub usernames.
- `members`: The members of the team as a set of GitHub usernames.

## Outputs

- `team_id`: The GitHub API id for the created team.
- `team_slug`: The URL-safe @-mentionable slug for the created team.
