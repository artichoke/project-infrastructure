variable "name" {
  description = "Name of the team"
  type        = string
}

variable "description" {
  description = "Description of the team"
  type        = string
}

variable "maintainers" {
  description = "The maintainers of the team as a set of GitHub usernames"
  type        = set(string)
}

variable "members" {
  description = "The members of the team as a set of GitHub usernames"
  type        = set(string)
}
