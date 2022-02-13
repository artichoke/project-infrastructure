# Update GitHub Repository File

This folder contains a Terraform module to write contents to a file in a
repository on GitHub. This module creates these changes on a new branch that may
be opened as a pull request.

## Usage

```terraform
module "ruby_version" {
  source   = "../modules/update-github-repository-file"
  for_each = toset([
    "artichoke",
    "playground",
    "project-infrastructure",
  ])

  organization  = "artichoke"
  repository    = each.value
  base_branch   = "trunk"
  file_path     = ".ruby-version"
  file_contents = "3.1.0\n"
}
```

## Parameters

- `organization`: The name of the GitHub organization that the target repository
  is a part of. For example, in
  <https://github.com/artichoke/project-infrastructure>, the GitHub organization
  is `artichoke`. This parameter defaults to `artichoke`.
- `repository`: The name of the repository to which this module will push the
  file contents. For example, in
  <https://github.com/artichoke/project-infrastructure>, the GitHub repository
  is `project-infrastructure`.
- `base_branch`: The git branch in the target repository to base the changes
  from. This parameter defaults to `trunk`.
- `file_path`: The file path to push the contents to. This is a relative path
  from the target repository root.
- `file_contents`: The raw file content to be written at `file_path`.

## Outputs

- `branch_href`: A URL to the newly-pushed branch on GitHub, from which a PR may
  be opened.
