variable "plan" {
  description = "Plan name"
  default     = "gha-oidc-provider"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-west-2"
  type        = string
}
