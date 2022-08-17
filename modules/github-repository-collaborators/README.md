# GitHub Repository Collaborators

This folder contains a Terraform module to add GitHub users as external
collaborators to a GitHub repository without making the user an organization
member.

## Usage

```terraform
module "strftime_ruby_collaborators" {
  source = "../modules/github-repository-collaborators"

  repository = "strftime-ruby"
  collaborators = [
    { user = "artichoke-ci", role = "push" },
  ]
}
```

## Parameters

- `repository`: The name of the GitHub repository to add the collaborators to.
- `members`: List of objects which contain GitHub usernames and the role to
  assign them.

## Outputs

This module has no outputs.
