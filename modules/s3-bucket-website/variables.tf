variable "bucket" {
  description = "The name of the bucket"
  type        = string
}

variable "access_logs_bucket" {
  description = "The name of the bucket to use as the destination for access logs"
  type        = string
}

variable "domains" {
  description = "List of domain names included in the ACM certificate and CloudFront distribution"
  type        = list(string)
  validation {
    condition     = alltrue([for d in var.domains : substr(d, -length(".artichokeruby.org"), length(".artichokeruby.org")) == ".artichokeruby.org"])
    error_message = "Domain must be a superdomain of artichokeruby.org."
  }
}
