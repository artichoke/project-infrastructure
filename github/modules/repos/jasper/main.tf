locals {
  repository = "jasper"
}

resource "github_repository" "this" {
  name        = local.repository
  description = "🧳Single-binary packaging for Ruby applications that supports native and Wasm targets"

  private = false

  has_downloads = true
  has_issues    = true
  has_projects  = true
  has_wiki      = true

  topics = [
    "artichoke",
    "ruby",
    "bundler",
    "packaging",
    "wasm",
    "webassembly",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

module "colors" {
  source = "../../colors"
}

module "labels" {
  source     = "../../labels/common"
  repository = local.repository
}

resource "github_issue_label" "target_wasm_emscripten" {
  repository = local.repository
  name = "O-wasm-emscripten"
  description = "Target: Support for building the `wasm32-unknown-emscripten` target."

  color = module.colors.target
}

resource "github_issue_label" "target_wasm_unknown" {
  repository = local.repository
  name = "O-wasm-unknown"
  description = "Target: Support for building the `wasm32-unknown-unknown` target."

  color = module.colors.target
}
