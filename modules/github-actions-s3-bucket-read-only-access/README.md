# GitHub OIDC S3 Bucket Read-Only Access

This folder contains a Terraform module to provision and OpenID Connect provider
in AWS and an IAM role to allow GitHub Actions in a specific repository read
access to an S3 bucket.

## Usage

```terraform
module "github_actions_project_infrastructure_assume_role" {
  source = "../modules/aws/github-actions-s3-bucket-read-only-access"

  github_organization = "artichoke"
  github_repository   = "project-infrastructure"

  s3_bucket_name = "artichoke-forge-project-infrastructure-terraform-state"
}
```

## Parameters

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