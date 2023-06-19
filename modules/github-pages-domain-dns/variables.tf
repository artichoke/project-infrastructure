variable "zone_id" {
  description = "The id of the Route53 zone to create GitHub Pages records in"
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
