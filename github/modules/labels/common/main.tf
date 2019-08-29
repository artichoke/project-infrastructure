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

resource "github_issue_label" "category_question" {
  repository = var.repository
  name = "C-question"
  description = "Category: Further information is requested."

  color = module.colors.category
}
