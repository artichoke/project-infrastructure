module "archived_artichoke_ci" {
  source = "../modules/archived-repository"

  name        = "artichoke-ci"
  description = "🏗 CI infrastructure and images for Artichoke"

  delete_branch_on_merge = false
  has_wiki               = true

  topics = [
    "base-image",
    "build",
    "ci",
    "circleci",
    "docker",
    "dockerfile",
  ]
}

module "archived_artichoke_onigmo" {
  source = "../modules/archived-repository"

  name        = "artichoke-onigmo"
  description = "Rust port / transpilation of Onigmo"
  visibility  = "private"

  delete_branch_on_merge = false
  has_wiki               = false

  topics            = []
  no_default_topics = true
}

module "archived_ferrocarril" {
  source = "../modules/archived-repository"

  name         = "ferrocarril"
  description  = "🚆 Experiments to embed Ruby on Rails in Rust with mruby"
  homepage_url = "https://artichoke.github.io/ferrocarril/mruby/"

  delete_branch_on_merge = false
  has_github_pages       = true
  has_wiki               = true

  topics = [
    "rack",
    "ruby",
    "rust",
    "sinatra",
    "unicorn",
  ]
}

module "archived_jasper" {
  source = "../modules/archived-repository"

  name         = "jasper"
  description  = "🧳 Single-binary packaging for Ruby applications that supports native and Wasm targets"
  homepage_url = null

  has_github_pages = false

  topics = [
    "bundler",
    "packaging",
    "ruby",
    "rust",
    "rust-application",
    "wasm",
    "webassembly",
  ]
}

module "archived_rust_mersenne_twister" {
  source = "../modules/archived-repository"

  name         = "rust-mersenne-twister"
  description  = "Fork migrated to artichoke/rand_mt"
  homepage_url = "https://github.com/artichoke/rand_mt"

  delete_branch_on_merge = true
  has_github_pages       = true
  has_issues             = false
  has_wiki               = true


  topics            = []
  no_default_topics = true
}

module "archived_rubyconf2019_artichoke_run" {
  source = "../modules/archived-repository"

  name         = "rubyconf2019.artichoke.run"
  description  = "📸 A snapshot of artichoke.run that runs the playground as of RubyConf 2019"
  homepage_url = "https://rubyconf2019.artichoke.run/"

  delete_branch_on_merge = true
  has_github_pages       = true

  github_pages_cname = "rubyconf2019.artichoke.run"

  topics = [
    "playground",
    "programming-language",
    "ruby",
    "rust",
    "rust-application",
    "snapshot",
    "wasm",
    "webassembly",
  ]
}
