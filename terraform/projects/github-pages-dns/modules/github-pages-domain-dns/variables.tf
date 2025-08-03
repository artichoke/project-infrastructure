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

variable "include_apex" {
  description = "Whether to include an apex record for the domain"
  type        = bool
  default     = true
}

variable "subdomains" {
  description = "List of subdomains to create records for"
  type        = list(string)
  default     = ["www"]

  validation {
    condition     = alltrue([for subdomain in var.subdomains : length(subdomain) > 0])
    error_message = "Subdomains must not be empty."
  }
}
