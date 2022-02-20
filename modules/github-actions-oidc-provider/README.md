# GitHub OIDC Provider

This folder contains a Terraform module to provision a GitHub Actions OpenID
Connect provider in AWS. This module should only be instantiated once per AWS
account since OpenID Connect providers must be globally unique per account.

The provider is for the `https://token.actions.githubusercontent.com` identity
provider.

## Usage

```terraform
module "github_actions_oidc_provider" {
  source = "../modules/github-actions-oidc-provider"
}
```

## Parameters

This action has no parameters.

## Outputs

- `arn`: The ARN for the created OpenID Connect provider.
