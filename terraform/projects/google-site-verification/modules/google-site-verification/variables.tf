variable "zone_id" {
  description = "The id of the Route53 zone to create DNS records in"
  type        = string
}

variable "site_verification_keys" {
  description = "Google site verification keys"
  type        = list(string)

  validation {
    condition     = length(var.site_verification_keys) > 0
    error_message = "Must provide at least one site verification key."
  }
}
