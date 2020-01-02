variable "repository" {}

module "colors" {
  source = "../../colors"
}

resource "github_issue_label" "area_build" {
  repository = var.repository
  name = "A-build"
  description = "Area: CI build infrastructure."

  color = module.colors.area
}

resource "github_issue_label" "area_deps" {
  repository = var.repository
  name = "A-deps"
  description = "Area: Source and library dependencies."

  color = module.colors.area
}

resource "github_issue_label" "area_project" {
  repository = var.repository
  name = "A-project"
  description = "Area: Infrastructure for creating an open source project."

  color = module.colors.area
}

resource "github_issue_label" "category_bug" {
  repository = var.repository
  name = "C-bug"
  description = "Category: This is a bug."

  color = module.colors.category
}

resource "github_issue_label" "category_docs" {
  repository = var.repository
  name = "C-docs"
  description = "Category: Improvements or additions to documentation."

  color = module.colors.category
}

resource "github_issue_label" "category_enhancement" {
  repository = var.repository
  name = "C-enhancement"
  description = "Category: New feature or request."

  color = module.colors.category
}

resource "github_issue_label" "category_quality" {
  repository = var.repository
  name = "C-quality"
  description = "Category: Refactoring, cleanup, and quality improvements."

  color = module.colors.category
}

resource "github_issue_label" "category_question" {
  repository = var.repository
  name = "C-question"
  description = "Category: Further information is requested."

  color = module.colors.category
}

resource "github_issue_label" "call_for_participation_easy" {
  repository = var.repository
  name = "E-easy"
  description = "Call for participation: Experience needed to fix: Easy / not much."

  color = module.colors.call_for_participation
}

resource "github_issue_label" "call_for_participation_hard" {
  repository = var.repository
  name = "E-hard"
  description = "Call for participation: Experience needed to fix: Hard / a lot."

  color = module.colors.call_for_participation
}

resource "github_issue_label" "call_for_participation_help_wanted" {
  repository = var.repository
  name = "E-help-wanted"
  description = "Call for participation: Help is requested to fix this issue."

  color = module.colors.call_for_participation
}

resource "github_issue_label" "call_for_participation_medium" {
  repository = var.repository
  name = "E-medium"
  description = "Call for participation: Experience needed to fix: Medium / intermediate."

  color = module.colors.call_for_participation
}

resource "github_issue_label" "call_for_participation_needs_test" {
  repository = var.repository
  name = "E-needs-test"
  description = "Call for participation: writing correctness tests."

  color = module.colors.call_for_participation
}

resource "github_issue_label" "status_blocked" {
  repository = var.repository
  name = "S-blocked"
  description = "Status: marked as blocked ❌ on something else such as other implementation work."

  color = module.colors.status
}

resource "github_issue_label" "status_do_not_merge" {
  repository = var.repository
  name = "S-do-not-merge"
  description = "Status: This pull request should not be merged."

  color = module.colors.status
}

resource "github_issue_label" "status_duplicate" {
  repository = var.repository
  name = "S-duplicate"
  description = "Status: This issue or pull request already exists."

  color = module.colors.status
}

resource "github_issue_label" "status_invalid" {
  repository = var.repository
  name = "S-invalid"
  description = "Status: This issue or pull request is not well-formed."

  color = module.colors.status
}

resource "github_issue_label" "status_wip" {
  repository = var.repository
  name = "S-wip"
  description = "Status: This pull request is a work in progress."

  color = module.colors.status
}

resource "github_issue_label" "status_wontfix" {
  repository = var.repository
  name = "S-wontfix"
  description = "Status: This issue or pull request will not be worked on."

  color = module.colors.status
}
