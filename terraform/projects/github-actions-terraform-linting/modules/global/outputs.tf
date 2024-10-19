output "role_arn" {
  value       = aws_iam_role.github_role.arn
  description = "This is the ARN of the role that can be assumed in GitHub Actions to access AWS resources"
}
