output "team_id" {
  description = "GitHub ID for the team"
  value       = github_team.this.id
}

output "team_slug" {
  description = "@-mentionable slug for the team"
  value       = github_team.this.slug
}
