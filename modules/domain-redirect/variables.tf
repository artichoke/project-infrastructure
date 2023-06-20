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
