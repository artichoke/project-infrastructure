variable "plan" {
  description = "Plan name"
  default     = "gha-tf-lint"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-west-2"
  type        = string
}
