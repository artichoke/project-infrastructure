# GitHub OIDC S3 Bucket Read-Only Access

This folder contains a Terraform module to provision an IAM role to allow GitHub
Actions in a specific repository read access to an S3 bucket using an existing
GitHub OpenID Connect provider.

## Usage

```terraform
module "github_actions_oidc_provider" {
  source = "../modules/github-actions-oidc-provider"
}

module "github_actions_project_infrastructure_assume_role" {
  source = "../modules/github-actions-s3-bucket-read-only-access"

  github_oidc_provider_arn = module.github_actions_oidc_provider.arn
  github_organization      = "artichoke"
  github_repository        = "project-infrastructure"

  s3_bucket_name = "artichoke-forge-project-infrastructure-terraform-state"
}
```

## Parameters

- `github_oidc_provider_arn`: AWS IAM OIDC provider ARN for
  `token.actions.githubusercontent.com`.
- `github_organization`: The name of the GitHub organization that the target
  repository is a part of. For example, in
  <https://github.com/artichoke/project-infrastructure>, the GitHub organization
  is `artichoke`.
- `github_repository`: The name of the repository to grant read access to. For
  example, in <https://github.com/artichoke/project-infrastructure>, the GitHub
  repository is `project-infrastructure`.
- `s3_bucket_name`: The name of the S3 bucket to which the target repository
  should be granted read-only access. This is only the name of the S3 bucket;
  not its ARN.

## Outputs

- `role_arn`: The ARN of the role that can be assumed in GitHub Actions to
  access AWS resources.

This module will output the name of a role that can be used with AWS GitHub
Actions for authenticating to AWS. For example:

```yaml
- name: Configure AWS Credentials
  uses: aws-actions/configure-aws-credentials@master
  with:
    aws-region: us-west-2
    role-to-assume: arn:aws:iam::447522982029:role/github-actions-artichoke-project-infrastructure-role
    role-session-name: GitHubActionsSession@tfsec-terraform
```
