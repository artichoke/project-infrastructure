resource "aws_kms_key" "this" {
  description         = var.description
  enable_key_rotation = true
}

resource "aws_kms_alias" "this" {
  name_prefix   = "alias/${var.alias_name_prefix}"
  target_key_id = aws_kms_key.this.key_id
}
