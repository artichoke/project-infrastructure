variable "description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
}

variable "alias_name_prefix" {
  description = "A prefix for the KMS key alias. This variable must be non-empty and must not start with `alias/`."
  type        = string

  validation {
    condition     = substr(var.alias_name_prefix, 0, 6) != "alias/"
    error_message = "The alias_name_prefix value must not start with `alias/`."
  }

  validation {
    condition     = length(var.alias_name_prefix) > 0
    error_message = "The alias_name_prefix value must not be empty."
  }
}
