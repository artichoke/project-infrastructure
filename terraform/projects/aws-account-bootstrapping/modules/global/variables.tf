variable "phase" {
  description = "Provisioning phase, either `per-host`, `per-cluster` or `global`"
  type        = string

  validation {
    condition     = var.phase == "per-host" || var.phase == "per-cluster" || var.phase == "global"
    error_message = "The phase variable must be either 'per-host', 'per-cluster', or 'global'."
  }
}

variable "plan" {
  description = "Plan name"
  type        = string

  validation {
    condition     = length(var.plan) >= 3 && !can(regex("womenliade", var.plan))
    error_message = "The plan variable must be at least 3 characters long and must not contain the string 'womenliade'."
  }
}

variable "region" {
  description = "AWS region"
  type        = string

  validation {
    condition     = contains(["us-west-2", "us-west-1", "us-east-1", "us-east-2"], var.region)
    error_message = "The region must be one of the following: us-west-2 (Oregon), us-west-1 (California), us-east-1, or us-east-2."
  }
}
