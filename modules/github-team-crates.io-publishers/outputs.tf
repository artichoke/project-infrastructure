output "id" {
  description = "GitHub ID for the team"
  value       = github_team.this.id
}

output "slug" {
  description = "@-mentionable slug for the team"
  value       = github_team.this.slug
}
