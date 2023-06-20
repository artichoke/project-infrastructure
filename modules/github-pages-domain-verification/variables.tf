variable "zone_id" {
  description = "The id of the Route53 zone to create TXT records in"
  type        = string
}

variable "github_organization" {
  description = "The GitHub organization slug"
  type        = string

  validation {
    condition     = length(var.github_organization) > 0
    error_message = "GitHub organization must not be empty."
  }
}

variable "domain" {
  description = "The domain to verify"
  type        = string

  validation {
    condition     = length(var.domain) > 0
    error_message = "Domain must not be empty."
  }
}

variable "challenge" {
  description = "The challenge token"
  type        = string

  validation {
    condition     = length(var.challenge) > 0 && length(var.challenge) < 255
    error_message = "Challenge token must not be empty and be shorter than 255 characters."
  }
}
