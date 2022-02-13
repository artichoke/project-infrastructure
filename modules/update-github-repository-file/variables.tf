variable "organization" {
  description = "Organization on GitHub, defaults to `artichoke`"
  default     = "artichoke"
  type        = string
}

variable "repository" {
  description = "Git repository on GitHub"
  type        = string
}

variable "base_branch" {
  description = "Branch to base the pull request from, defaults to `trunk`"
  default     = "trunk"
  type        = string
}

variable "file_path" {
  description = "Path for the file to update in the given repository, relative to the repository root"
  type        = string
}

variable "file_contents" {
  description = "Content to write at the given file path"
  type        = string
}
