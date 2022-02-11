locals {
  github_organization = "artichoke"
  github_repository   = "project-infrastructure"
}

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"]
}

data "aws_iam_policy_document" "github_allow" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github.arn]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:${local.github_organization}/${local.github_repository}:*"]
    }
  }
}

resource "aws_iam_role" "github_role" {
  name               = "github-actions-${local.github_organization}-${local.github_repository}-role"
  assume_role_policy = data.aws_iam_policy_document.github_allow.json
}

data "aws_iam_policy_document" "terraform_state_read_only" {
  statement {
    sid = 1

    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::artichoke-forge-project-infrastructure-terraform-state"]
  }

  statement {
    sid = 2

    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]
    resources = ["arn:aws:s3:::artichoke-forge-project-infrastructure-terraform-state/*"]
  }
}

resource "aws_iam_policy" "terraform_state_read_only" {
  name   = "github-actions-${local.github_organization}-${local.github_repository}-tf-state-ro"
  policy = data.aws_iam_policy_document.terraform_state_read_only.json
}

resource "aws_iam_role_policy_attachment" "terraform_state_read_only" {
  role       = aws_iam_role.github_role.name
  policy_arn = aws_iam_policy.terraform_state_read_only.arn
}

output "role_arn" {
  value = aws_iam_role.github_role.arn
}
