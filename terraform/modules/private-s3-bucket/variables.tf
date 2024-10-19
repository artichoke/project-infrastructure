variable "bucket" {
  description = "The name of the bucket"
  type        = string

  validation {
    condition     = length(var.bucket) >= 3 && var.bucket != ""
    error_message = "The bucket name must be at least 3 characters long and cannot be empty."
  }
}

variable "access_logs_bucket" {
  description = "The name of the bucket to use as the destination for access logs"
  type        = string

  validation {
    condition     = length(var.access_logs_bucket) >= 3 && var.access_logs_bucket != ""
    error_message = "The access logs bucket name must be at least 3 characters long and cannot be empty."
  }
}

variable "write_protected" {
  description = "If true, the bucket will deny all write operations and always be empty"
  type        = bool
  default     = false
}
