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
