# GitHub OpenID Connect with cloud providers
#
# https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-cloud-providers

data "aws_iam_policy_document" "github_allow" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [var.github_oidc_provider_arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${var.github_organization}/${var.github_repository}:*"]
    }
  }
}

resource "aws_iam_role" "github_role" {
  name_prefix        = "gha-${var.github_repository}-s3-ro-"
  assume_role_policy = data.aws_iam_policy_document.github_allow.json
}

data "aws_s3_bucket" "bucket" {
  bucket = var.s3_bucket_name
}

data "aws_iam_policy_document" "bucket_read_only" {
  statement {
    sid = 1

    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]
    resources = [data.aws_s3_bucket.bucket.arn]
  }

  statement {
    sid = 2

    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]
    resources = ["${data.aws_s3_bucket.bucket.arn}/*"]
  }
}

resource "aws_iam_policy" "bucket_read_only" {
  name_prefix = "${var.github_organization}-${var.github_repository}-${var.s3_bucket_name}-s3-ro-"
  policy      = data.aws_iam_policy_document.bucket_read_only.json
}

resource "aws_iam_role_policy_attachment" "bucket_read_only" {
  role       = aws_iam_role.github_role.name
  policy_arn = aws_iam_policy.bucket_read_only.arn
}
