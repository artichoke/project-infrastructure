variable "bucket" {
  description = "The name of the bucket"
  type        = string
}

variable "access_logs_bucket" {
  description = "The name of the bucket to use as the destination for access logs"
  type        = string
}
