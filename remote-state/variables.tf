variable "environment" {
  description = "Terraform environment bulkhead"
  default     = "remote-state"
  type        = string
}

variable "project" {
  description = "Workspace name"
  default     = "artichoke-forge"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-west-2"
  type        = string
}
