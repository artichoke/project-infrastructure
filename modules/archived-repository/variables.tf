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

variable "delete_branch_on_merge" {
  description = "Automatically delete head branch after a pull request is merged"
  default     = true
  type        = bool
}

variable "has_downloads" {
  description = "Set to true if (deprecated) downloads were enabled on the repository"
  default     = true
  type        = bool
}

variable "has_issues" {
  description = "Set to true to if GitHub Issues were enabled on the repository"
  default     = true
  type        = bool
}

variable "has_projects" {
  description = "Set to true if GitHub Projects were enabled on the repository"
  default     = false
  type        = bool
}

variable "has_wiki" {
  description = "Set to true if GitHub Wiki was enabled on the repository"
  default     = false
  type        = bool
}

variable "vulnerability_alerts" {
  description = "Set to true to enable security alerts for vulnerable dependencies"
  default     = false
  type        = bool
}

variable "has_github_pages" {
  description = "Set to true if a GitHub Pages deploy was enabled on the repository"
  default     = false
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
