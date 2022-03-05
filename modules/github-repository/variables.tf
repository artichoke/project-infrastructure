variable "name" {
  description = "The name of the repository"
  type        = string
}

variable "description" {
  description = "A description of the repository"
  type        = string
}

variable "homepage_url" {
  description = "A URL of the page describing the project"
  default     = null
  type        = string
}

variable "has_github_pages" {
  description = "Set to true if a GitHub Pages deploy was enabled on the repository"
  default     = true
  type        = bool
}

variable "github_pages_cname" {
  description = "CNAME record for GitHub Pages deployment"
  default     = null
  type        = string
}

variable "topics" {
  description = "The list of topics of the repository"
  type        = list(string)
}
