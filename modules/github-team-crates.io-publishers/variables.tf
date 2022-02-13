variable "name" {
  description = "Name of the team, defaults to `crates.io publishers`"
  default     = "crates.io publishers"
  type        = string
}

variable "description" {
  description = "Description of the team"
  type        = string
}
