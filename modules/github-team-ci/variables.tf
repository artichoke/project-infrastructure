variable "name" {
  description = "Name of the team, defaults to `ci`"
  default     = "ci"
  type        = string
}

variable "description" {
  description = "Description of the team"
  type        = string
}
