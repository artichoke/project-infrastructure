# GitHub Repository

This folder contains a Terraform module to manage GitHub repositories that are actively
receiving commits.

## Usage

```terraform
module "repo_artichoke" {
  source = "../modules/github-repository"

  name         = "artichoke"
  description  = "💎 Artichoke is a Ruby made with Rust"
  homepage_url = "https://www.artichokeruby.org/"

  topics = [
    "artichoke",
    "language",
    "programming-language",
    "ruby",
    "ruby-language",
    "rust",
    "rust-application",
    "rust-crate",
    "wasm",
    "webassembly",
  ]
}
```

## Parameters

- `name`: The name of the repository.
- `description`: A description of the repository.
- `homepage_url`: A URL of the page describing the project, defaults to `null`.
- `has_github_pages`: Set to true if a GitHub Pages deploy was enabled on the
  repository, defaults to `true`.
- `github_pages_cname`: CNAME record for GitHub Pages deployment, defaults to
  `null`, only has an effect if `has_github_pages` is `true`.
- `topics`: The list of topics of the repository.

## Outputs

This module has no outputs.
