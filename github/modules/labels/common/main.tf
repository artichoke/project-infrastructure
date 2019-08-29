variable "repository" {}

module "colors" {
  source = "../../colors"
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
