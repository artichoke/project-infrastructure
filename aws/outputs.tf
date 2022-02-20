output "github_actions_project_infrastructure_assume_role_arn" {
  description = "This is the ARN of the role that can be assumed in GitHub Actions to access AWS resources"
  value       = module.github_actions_project_infrastructure_assume_role.role_arn
}

output "github_actions_s3_backup_assume_role_arn" {
  description = "This is the ARN of the role that can be assumed in GitHub Actions to access AWS resources"
  value       = { for repo, m in module.github_actions_s3_backups_assume_role : repo => m.role_arn }
}
