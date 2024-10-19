# GitHub OpenID Connect with cloud providers
#
# https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/configuring-openid-connect-in-cloud-providers

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  # Thumbprint documentation:
  #
  # https://github.blog/changelog/2022-01-13-github-actions-update-on-oidc-based-deployments-to-aws/
  # https://github.blog/changelog/2023-06-27-github-actions-update-on-oidc-integration-with-aws/
  # https://github.com/artichoke/project-infrastructure/issues/533
  # https://github.com/aws-actions/configure-aws-credentials/blob/0270d0bcecaf2c76c8fbf7bf3de0d65a6d06e076/README.md#recent-updates
  thumbprint_list = [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd",
  ]
}
