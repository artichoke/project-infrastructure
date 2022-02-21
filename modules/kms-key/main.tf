data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "key_policy" {
  statement {
    sid       = "Enable IAM User Permissions"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  statement {
    sid       = "Allow access for Key Administrators"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"
      ]
    }
  }

  statement {
    sid    = "Allow use of the key"
    effect = "Allow"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = concat(
        [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport",
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"
        ],
        var.roles_with_key_access
      )
    }
  }

  statement {
    sid    = "Allow attachment of persistent resources"
    effect = "Allow"
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/support.amazonaws.com/AWSServiceRoleForSupport",
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/trustedadvisor.amazonaws.com/AWSServiceRoleForTrustedAdvisor"
      ]
    }

    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
}
resource "aws_kms_key" "this" {
  description         = var.description
  policy              = data.aws_iam_policy_document.key_policy.json
  enable_key_rotation = true
}

resource "aws_kms_alias" "this" {
  name_prefix   = "alias/${var.alias_name_prefix}"
  target_key_id = aws_kms_key.this.key_id
}
