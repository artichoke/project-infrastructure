# Archived Repository

This folder contains a Terraform module to manage archived GitHub repositories.

## Usage

```terraform
module "archived_ferrocarril" {
  source = "../modules/archived-repository"

  name         = "ferrocarril"
  description  = "🚆 Experiments to embed Ruby on Rails in Rust with mruby"
  homepage_url = "https://artichoke.github.io/ferrocarril/mruby/"

  delete_branch_on_merge = false
  has_github_pages       = true
  has_wiki               = true

  topics = [
    "artichoke",
    "rack",
    "ruby",
    "rust",
    "sinatra",
    "unicorn",
  ]
}
```

## Parameters

- `name`: The name of the repository.
- `description`: A description of the repository.
- `homepage_url`: A URL of the page describing the project, defaults to `null`.
- `delete_branch_on_merge`: Automatically delete head branch after a pull
  request is merged, defaults to `true`.
- `has_downloads`: Set to true if (deprecated) downloads were enabled on the
  repository, defaults to `true`.
- `has_issues`: Set to true to if GitHub Issues were enabled on the repository,
  defaults to `true`.
- `has_projects`: Set to true if GitHub Projects were enabled on the repository,
  defaults to `false`.
- `has_wiki`: Set to true if GitHub Wiki was enabled on the repository, defaults
  to `false`.
- `vulnerability_alerts`: Set to true if a GitHub Pages deploy was enabled on
  the repository, defaults to `false`.
- `has_github_pages`: Set to true if a GitHub Pages deploy was enabled on the
  repository, defaults to `false`.
- `github_pages_cname`: CNAME record for GitHub Pages deployment, defaults to
  `null`, only has an effect if `has_github_pages` is `true`.
- `topics`: The list of topics of the repository.

## Outputs

This module has no outputs.
