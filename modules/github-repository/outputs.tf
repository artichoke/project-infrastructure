output "full_name" {
  description = "A string of the form orgname/reponame"
  value       = github_repository.this.full_name
}

output "repo_id" {
  description = "GitHub ID for the repository"
  value       = github_repository.this.repo_id
}
