terraform {
  backend "s3" {
    bucket       = "artichoke-forge-project-infrastructure-terraform-state"
    region       = "us-west-2"
    key          = "github-org-artichoke-ruby/terraform.tfstate"
    encrypt      = true
    use_lockfile = true
  }
}

resource "github_organization_settings" "this" {
  billing_email                                                = "github-billing@artichokeruby.org"
  blog                                                         = "https://www.artichokeruby.org"
  email                                                        = "github@artichokeruby.org"
  twitter_username                                             = "artichokeruby"
  name                                                         = "Artichoke Ruby (alternate)"
  description                                                  = "Alternate GitHub organization for artichoke to protect against typosquatting"
  has_organization_projects                                    = false
  has_repository_projects                                      = false
  default_repository_permission                                = "read"
  members_can_create_repositories                              = true
  members_can_create_public_repositories                       = true
  members_can_create_private_repositories                      = true
  members_can_create_internal_repositories                     = false
  members_can_create_pages                                     = true
  members_can_create_public_pages                              = true
  members_can_create_private_pages                             = true
  members_can_fork_private_repositories                        = false
  web_commit_signoff_required                                  = false
  advanced_security_enabled_for_new_repositories               = false
  dependabot_alerts_enabled_for_new_repositories               = true
  dependabot_security_updates_enabled_for_new_repositories     = true
  dependency_graph_enabled_for_new_repositories                = true
  secret_scanning_enabled_for_new_repositories                 = true
  secret_scanning_push_protection_enabled_for_new_repositories = true
}

module "org_members" {
  source = "../modules/github-organization-members"

  admins = toset([
    "lopopolo",
  ])

  members = toset([
    "artichoke-ci",
  ])
}
