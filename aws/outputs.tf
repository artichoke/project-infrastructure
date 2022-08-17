output "github_actions_project_infrastructure_assume_role_arn" {
  description = "This is the ARN of the role that can be assumed in GitHub Actions to access AWS resources"
  value       = module.github_actions_project_infrastructure_assume_role.role_arn
}

output "github_actions_s3_backup_assume_role_arn" {
  description = "This is the ARN of the role that can be assumed in GitHub Actions to access AWS resources"
  value       = { for repo, m in module.github_actions_s3_backups_assume_role : repo => m.role_arn }
}

output "github_actions_s3_backup_s3_bucket" {
  description = "The bucket name for GitHub backups"
  value       = module.repo_backups.name
}

output "github_actions_code_coverage_assume_role_arn" {
  description = "This is the ARN of the role that can be assumed in GitHub Actions to access AWS resources"
  value       = { for repo, m in module.github_actions_code_coverage_assume_role : repo => m.role_arn }
}

output "code_coverage_s3_bucket" {
  description = "The bucket name for code coverage"
  value       = module.code_coverage.name
}

output "code_coverage_cloudfront_domain" {
  description = "The CloudFront domain name for the code coverage website"
  value       = module.code_coverage.name
}
