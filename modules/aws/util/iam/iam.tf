#--------------------------------------------------------------
# This module is used to create an AWS IAM group and its users
#--------------------------------------------------------------

variable "name" {
  type = string
}

variable "users" {
  type = map(string)
}

variable "policy" {
  type = string
}

resource "aws_iam_group" "group" {
  name = var.name
}

resource "aws_iam_group_policy" "policy" {
  name   = var.name
  group  = aws_iam_group.group.id
  policy = var.policy
}

resource "aws_iam_user" "user" {
  for_each = var.users

  name = each.value
}

resource "aws_iam_access_key" "key" {
  for_each = var.users

  user = aws_iam_user.user[each.key].name
}

resource "aws_iam_group_membership" "membership" {
  name  = var.name
  group = aws_iam_group.group.name
  users = [for user in aws_iam_user.user : user.name]
}

output "users" {
  value = { for user, access_key in aws_iam_access_key.key : user => access_key.user }
}

output "access_ids" {
  value = { for user, access_key in aws_iam_access_key.key : user => access_key.id }
}

output "secret_keys" {
  value = { for user, access_key in aws_iam_access_key.key : user => access_key.secret }

  sensitive = true
}
