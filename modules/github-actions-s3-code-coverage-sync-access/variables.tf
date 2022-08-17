variable "github_oidc_provider_arn" {
  description = "AWS IAM OIDC provider ARN for token.actions.githubusercontent.com"
  type        = string
}

variable "github_organization" {
  description = "The GitHub organization to grant access to"
  type        = string
}

variable "github_repository" {
  description = "The GitHub repository in the organization to grant access to"
  type        = string
}

variable "s3_bucket_name" {
  description = "The S3 bucket to grant access to"
  type        = string
}
