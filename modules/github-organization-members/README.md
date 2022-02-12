# GitHub Organization Members

This folder contains a Terraform module to add GitHub users to a GitHub
organization.

## Usage

```terraform
module "org_members" {
  source = "../modules/github-organization-members"

  admins = toset([
    "lopopolo",
  ])

  members = toset([
    "artichoke-ci",
  ])
}
```

## Parameters

- `admins`: A `set` of GitHub usernames to make admins of the organization.
- `members`: A `set` of GitHub usernames to make regular members of the
  organization.

## Outputs

This module has no outputs.
