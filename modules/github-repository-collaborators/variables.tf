variable "repository" {
  description = "The name of the GitHub repository to add the collaborators to"
  type        = string
  validation {
    condition     = length(var.repository) > 0
    error_message = "Must be a non-empty string."
  }
}

variable "collaborators" {
  description = "List of objects which contain GitHub usernames and the role to assign them"
  type        = list(object({ user = string, role = string }))
  validation {
    condition     = alltrue([for config in var.collaborators : contains(["pull", "push", "maintain", "triage"], config.role)])
    error_message = "Role must be one of 'pull', 'push', 'maintain', or 'triage'."
  }
  validation {
    condition     = alltrue([for config in var.collaborators : length(config.user) > 0])
    error_message = "User must be a non-empty string."
  }
  validation {
    condition     = length(var.collaborators) == length(distinct([for config in var.collaborators : config.user]))
    error_message = "Must not contain duplicate users."
  }
}
