output "github_oidc_arn" {
  value       = aws_iam_openid_connect_provider.github.arn
  description = "This is the ARN of the OpenID Connect provider that can be used in GitHub Actions to access AWS resources"
}
