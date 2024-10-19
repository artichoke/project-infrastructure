locals {
  remote_state_bucket = "artichoke-forge-project-infrastructure-terraform-state"
  github_organization = "artichoke"
  github_repository   = "project-infrastructure"
}

data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# GitHub OpenID Connect with cloud providers
#
# https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-cloud-providers

data "aws_iam_policy_document" "github_allow" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${local.github_organization}/${local.github_repository}:*"]
    }
  }
}

resource "aws_iam_role" "github_role" {
  name_prefix        = "${var.plan}-${local.github_organization}-s3-ro-"
  assume_role_policy = data.aws_iam_policy_document.github_allow.json
}

data "aws_s3_bucket" "bucket" {
  bucket = local.remote_state_bucket
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
    resources = ["${data.aws_s3_bucket.bucket.arn}/*"] # tfsec:ignore:aws-iam-no-policy-wildcards
  }
}

resource "aws_iam_policy" "bucket_read_only" {
  name_prefix = "${var.plan}-${local.github_organization}-${local.github_repository}-s3-ro-"
  policy      = data.aws_iam_policy_document.bucket_read_only.json
}

resource "aws_iam_role_policy_attachment" "bucket_read_only" {
  role       = aws_iam_role.github_role.name
  policy_arn = aws_iam_policy.bucket_read_only.arn
}
