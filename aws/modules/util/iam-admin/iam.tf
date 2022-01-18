# --------------------------------------------------------------------------- #
# This module is used to create an AWS IAM users with AdministratorAccess     #
# permissions.                                                                #
# --------------------------------------------------------------------------- #

variable "users" {
  type = map(string)
}

resource "aws_iam_user" "user" {
  for_each = var.users

  name = each.value
}

resource "aws_iam_user_policy_attachment" "admin" {
  for_each = var.users

  user       = aws_iam_user.user[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "key" {
  for_each = var.users

  user = aws_iam_user.user[each.key].name
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
