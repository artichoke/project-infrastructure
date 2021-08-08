resource "aws_iam_account_password_policy" "this" {
  minimum_password_length = 35

  require_lowercase_characters = true
  require_numbers              = true
  require_uppercase_characters = true
  require_symbols              = true

  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 5
  hard_expiry                    = false
}
