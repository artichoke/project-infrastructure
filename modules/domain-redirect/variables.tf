variable "access_logs_bucket" {
  description = "The name of the bucket to use as the destination for access logs"
  type        = string
}

variable "zone_id" {
  description = "The id of the Route53 zone to create redirect records in"
  type        = string
}

variable "redirect_to" {
  description = "The website to redirect to"

  validation {
    condition     = length(var.redirect_to) > length("https://x.x")
    error_message = "Redirect target must be properly formatted."
  }

  validation {
    condition     = startswith(var.redirect_to, "https://")
    error_message = "Redirect target must be an HTTPs URL."
  }

  validation {
    condition     = !endswith(var.redirect_to, "/")
    error_message = "Redirect target must be a URL that does not end in `/`."
  }
}

variable "subdomains" {
  description = "The list of subdomains to redirect"
  type        = list(string)
  default     = ["www"]

  validation {
    condition     = alltrue([for subdomain in var.subdomains : length(subdomain) > 0])
    error_message = "All subdomains must be non-empty strings."
  }
}

variable "include_apex" {
  description = "Whether to redirect the apex domain as well as the given subdomains"
  type        = bool
  default     = true
}

variable "suffix" {
  description = "A suffix to append to the bucket name to ensure uniqueness"
  type        = string
  default     = ""
}
