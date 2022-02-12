output "github_actions_project_infrastructure_assume_role_arn" {
  value       = module.github_actions_project_infrastructure_assume_role.role_arn
  description = "This is the ARN of the role that can be assumed in GitHub Actions to access AWS resources"
}
