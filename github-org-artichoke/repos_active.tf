module "github_artichoke" {
  source = "../modules/github-repository"

  name         = "artichoke"
  description  = "💎 Artichoke is a Ruby made with Rust"
  homepage_url = "https://www.artichokeruby.org/"

  topics = [
    "language",
    "programming-language",
    "ruby",
    "ruby-language",
    "rust",
    "rust-application",
    "rust-crate",
    "wasm",
    "webassembly",
  ]
}

module "github_artichoke_github_io" {
  source = "../modules/github-repository"

  name         = "artichoke.github.io"
  description  = "⏭ Redirect to Artichoke project website"
  homepage_url = "https://artichoke.github.io/"

  topics = [
    "gh-pages",
    "project-website",
    "static-site",
  ]
}

module "github_boba" {
  source = "../modules/github-repository"

  name         = "boba"
  description  = "💦 Rust implementation of the Bubble Babble binary data encoding"
  homepage_url = "https://crates.io/crates/boba"

  topics = [
    "bubblebabble",
    "decoding",
    "encoding",
    "ruby",
    "rust",
    "rust-crate",
  ]
}

module "github_cactusref" {
  source = "../modules/github-repository"

  name         = "cactusref"
  description  = "🌵 Cycle-Aware Reference Counting in Rust"
  homepage_url = "https://crates.io/crates/cactusref"

  topics = [
    "garbage-collection",
    "garbage-collector",
    "memory-management",
    "reference-counting",
    "rust",
    "rust-crate",
  ]
}

module "github_clang_format" {
  source = "../modules/github-repository"

  name         = "clang-format"
  description  = "✏️ clang-format runner for CI"
  homepage_url = "https://github.com/artichoke/clang-format#readme"

  has_github_pages = false

  topics = [
    "c",
    "ci",
    "clang-format",
    "formatter",
    "javascript",
    "linter",
    "nodejs",
    "npx",
  ]
}

module "github_docker_artichoke_nightly" {
  source = "../modules/github-repository"

  name         = "docker-artichoke-nightly"
  description  = "🐳 Docker builds for nightly Artichoke"
  homepage_url = "https://hub.docker.com/r/artichokeruby/artichoke"

  has_github_pages = false

  topics = [
    "docker",
    "nightly",
    "nightly-build",
    "ruby",
    "rust",
    "rust-application",
  ]
}

module "github_focaccia" {
  source = "../modules/github-repository"

  name         = "focaccia"
  description  = "🍞 no_std Unicode case folding comparisons"
  homepage_url = "https://crates.io/crates/focaccia"

  topics = [
    "case",
    "case-folding",
    "no-std",
    "rust",
    "rust-crate",
    "unicode",
    "unicode-case-folding",
    "utf-8"
  ]
}

module "github_intaglio" {
  source = "../modules/github-repository"

  name         = "intaglio"
  description  = "🗃 UTF-8 string, byte string, and C string interner"
  homepage_url = "https://crates.io/crates/intaglio"

  topics = [
    "bytes",
    "interner",
    "rust",
    "rust-crate",
    "string-interning",
    "symbol",
    "symbol-table",
    "utf-8",
  ]
}

module "github_jasper" {
  source = "../modules/github-repository"

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

module "github_logo" {
  source = "../modules/github-repository"

  name         = "logo"
  description  = "🖼 Project logos for Artichoke Ruby"
  homepage_url = "https://www.npmjs.com/package/@artichokeruby/logo"

  topics = [
    "branding",
    "javascript",
    "logo",
    "static-assets",
  ]
}

module "github_nightly" {
  source = "../modules/github-repository"

  name         = "nightly"
  description  = "🌌 Nightly builds of Artichoke Ruby"
  homepage_url = "https://github.com/artichoke/nightly/releases/latest"

  has_github_pages = false

  topics = [
    "nightly",
    "nightly-build",
    "ruby",
    "rust",
    "rust-application",
  ]
}

module "github_playground" {
  source = "../modules/github-repository"

  name         = "playground"
  description  = "🎡 Artichoke Ruby Wasm Playground"
  homepage_url = "https://artichoke.run/"

  github_pages_cname = "artichoke.run"

  topics = [
    "playground",
    "programming-language",
    "ruby",
    "rust",
    "rust-application",
    "wasm",
    "webassembly",
  ]
}

module "github_project_infrastructure" {
  source = "../modules/github-repository"

  name         = "project-infrastructure"
  description  = "🛠 Infrastructure as code for the Artichoke open source project"
  homepage_url = "https://github.com/artichoke/project-infrastructure/tree/trunk/docs"

  has_github_pages = false

  topics = [
    "infrastructure-as-code",
    "meta",
    "terraform",
  ]
}

module "github_rand_mt" {
  source = "../modules/github-repository"

  name         = "rand_mt"
  description  = "🌪 Mersenne Twister implementation backed by rand_core"
  homepage_url = "https://crates.io/crates/rand_mt"

  topics = [
    "mersenne-twister",
    "no-std",
    "rand",
    "random",
    "rng",
    "rust",
    "rust-crate",
  ]
}

module "github_raw_parts" {
  source = "../modules/github-repository"

  name         = "raw-parts"
  description  = "🪣 Types for a `Vec`'s raw parts"
  homepage_url = "https://crates.io/crates/raw-parts"

  topics = [
    "ffi",
    "no-std",
    "pointers",
    "rust",
    "rust-crate",
    "vector",
  ]
}

module "github_roe" {
  source = "../modules/github-repository"

  name         = "roe"
  description  = "🍣 Unicode case converters"
  homepage_url = "https://crates.io/crates/roe"

  topics = [
    "case",
    "case-mapping",
    "lowercase",
    "no-std",
    "rust",
    "rust-crate",
    "titlecase",
    "unicode",
    "unicode-case-mapping",
    "uppercase",
    "utf-8"
  ]
}

module "github_rubyconf" {
  source = "../modules/github-repository"

  name         = "rubyconf"
  description  = "📽 RubyConf presentations"
  homepage_url = "https://artichoke.github.io/rubyconf/"

  topics = [
    "conference-talk",
    "deck",
    "gh-pages",
    "presentation",
    "ruby",
    "rubyconf",
    "slideshow",
    "static-site",
    "wasm",
    "webassembly",
  ]
}

module "github_ruby_file_expand_path" {
  source = "../modules/github-repository"

  name         = "ruby-file-expand-path"
  description  = "📂 Rust port of path normalization from MRI Ruby."
  homepage_url = "https://artichoke.github.io/ruby-file-expand-path/ruby_file_expand_path/"

  topics = [
    "ffi",
    "filesystem",
    "ruby",
    "ruby-language",
    "rust",
    "rust-crate",
    "windows",
  ]
}

module "github_spec_state" {
  source = "../modules/github-repository"

  name         = "spec-state"
  description  = "💎📈 Records historical ruby/spec compliance for Artichoke"
  homepage_url = "https://github.com/artichoke/spec-state/tree/trunk/reports"

  has_github_pages = false

  topics = [
    "language-specs",
    "ruby",
    "rubyspec",
  ]
}

module "github_strudel" {
  source = "../modules/github-repository"

  name         = "strudel"
  description  = "🥐 🥮 Rust port and drop-in replacement for the `st_hash` C hash table library"
  homepage_url = "https://artichoke.github.io/strudel/strudel/"

  topics = [
    "c",
    "ffi",
    "hashmap",
    "ruby",
    "rust",
    "rust-crate",
  ]
}

module "github_www_artichokeruby_org" {
  source = "../modules/github-repository"

  name         = "www.artichokeruby.org"
  description  = "🌐 Artichoke Ruby project website"
  homepage_url = "https://www.artichokeruby.org/"

  github_pages_cname = "www.artichokeruby.org"

  topics = [
    "gh-pages",
    "project-website",
    "static-site",
  ]
}
