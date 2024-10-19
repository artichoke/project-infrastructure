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
    condition     = length(var.plan) >= 3 && !can(regex("artichoke", var.plan))
    error_message = "The plan variable must be at least 3 characters long and must not contain the string 'artichoke'."
  }
}
