variable "admins" {
  description = "GitHub users who are organization admins"
  type        = set(string)
}

variable "members" {
  description = "GitHub users who are organization members"
  type        = set(string)
}
