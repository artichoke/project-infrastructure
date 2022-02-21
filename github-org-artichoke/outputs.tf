output "audit_workflow_node_branches" {
  description = "Links to GitHub with changes to the `audit` workflow for Node.js repos"
  value       = join("\n", concat(length(module.audit_workflow_node) == 0 ? [] : ["## Branches", ""], formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_node : audit_workflow.branch_href])))
}

output "audit_workflow_ruby_branches" {
  description = "Links to GitHub with changes to the `audit` workflow for Ruby repos"
  value       = join("\n", concat(length(module.audit_workflow_ruby) == 0 ? [] : ["## Branches", ""], formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_ruby : audit_workflow.branch_href])))
}

output "audit_workflow_node_ruby_branches" {
  description = "Links to GitHub with changes to the `audit` workflow for Node.js and Ruby repos"
  value       = join("\n", concat(length(module.audit_workflow_node_ruby) == 0 ? [] : ["## Branches", ""], formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_node_ruby : audit_workflow.branch_href])))
}

output "audit_workflow_ruby_rust_branches" {
  description = "Links to GitHub with changes to the `audit` workflow for Ruby and Rust repos"
  value       = join("\n", concat(length(module.audit_workflow_ruby_rust) == 0 ? [] : ["## Branches", ""], formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_ruby_rust : audit_workflow.branch_href])))
}

output "audit_workflow_node_ruby_rust_branches" {
  description = "Links to GitHub with changes to the `audit` workflow for Node.js, Ruby, and Rust repos"
  value       = join("\n", concat(length(module.audit_workflow_node_ruby_rust) == 0 ? [] : ["## Branches", ""], formatlist("- %s", [for repo, audit_workflow in module.audit_workflow_node_ruby_rust : audit_workflow.branch_href])))
}

output "s3_backup_workflow_branches" {
  description = "Links to GitHub with changes to the `s3-backup` workflow"
  value       = join("\n", concat(length(module.s3_backup_workflow) == 0 ? [] : ["## Branches", ""], formatlist("- %s", [for repo, backup_workflow in module.s3_backup_workflow : backup_workflow.branch_href])))
}

output "ruby_version_branches" {
  description = "A list of links to branches on GitHub with changes to .ruby-version"
  value       = join("\n", concat(length(module.ruby_version) == 0 ? [] : ["## Branches", ""], formatlist("- %s", [for repo, ruby_version in module.ruby_version : ruby_version.branch_href])))
}

