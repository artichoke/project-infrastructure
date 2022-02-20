output "arn" {
  value       = aws_iam_openid_connect_provider.github.arn
  description = "This is the ARN of the GitHub OpenID Connect provider"
}
