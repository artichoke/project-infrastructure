resource "github_repository" "artichoke" {
  name         = "artichoke"
  description  = "💎 Artichoke is a Ruby made with Rust"
  homepage_url = "https://www.artichokeruby.org/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
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

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "artichoke_github_io" {
  name         = "artichoke.github.io"
  description  = "⏭ Redirect to Artichoke project website"
  homepage_url = "https://artichoke.github.io/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "gh-pages",
    "project-website",
    "static-site",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "boba" {
  name         = "boba"
  description  = "💦 Rust implementation of the Bubble Babble binary data encoding"
  homepage_url = "https://crates.io/crates/boba"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "bubblebabble",
    "decoding",
    "encoding",
    "ruby",
    "rust",
    "rust-crate",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "cactusref" {
  name         = "cactusref"
  description  = "🌵 Cycle-Aware Reference Counting in Rust"
  homepage_url = "https://artichoke.github.io/cactusref/cactusref/"

  archived   = false
  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "garbage-collection",
    "garbage-collector",
    "memory-management",
    "reference-counting",
    "rust",
    "rust-crate",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "clang_format" {
  name         = "clang-format"
  description  = "✏️ clang-format runner for CI"
  homepage_url = "https://github.com/artichoke/clang-format#readme"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "c",
    "ci",
    "clang-format",
    "formatter",
    "javascript",
    "linter",
    "nodejs",
    "npx",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "docker_artichoke_nightly" {
  name         = "docker-artichoke-nightly"
  description  = "🐳 Docker builds for nightly Artichoke"
  homepage_url = "https://hub.docker.com/r/artichokeruby/artichoke"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "docker",
    "nightly",
    "nightly-build",
    "ruby",
    "rust",
    "rust-application",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "focaccia" {
  name         = "focaccia"
  description  = "🍞 no_std Unicode case folding comparisons"
  homepage_url = "https://crates.io/crates/focaccia"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "case",
    "case-folding",
    "no-std",
    "rust",
    "rust-crate",
    "unicode",
    "unicode-case-folding",
    "utf-8"
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "intaglio" {
  name         = "intaglio"
  description  = "🗃 UTF-8 string and bytestring interner"
  homepage_url = "https://crates.io/crates/intaglio"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "bytes",
    "interner",
    "rust",
    "rust-crate",
    "string-interning",
    "symbol",
    "symbol-table",
    "utf-8",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "jasper" {
  name        = "jasper"
  description = "🧳 Single-binary packaging for Ruby applications that supports native and Wasm targets"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "bundler",
    "packaging",
    "ruby",
    "rust",
    "rust-application",
    "wasm",
    "webassembly",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "logo" {
  name         = "logo"
  description  = "🖼 Project logos for Artichoke Ruby"
  homepage_url = "https://www.npmjs.com/package/@artichokeruby/logo"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "branding",
    "javascript",
    "logo",
    "static-assets",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "nightly" {
  name         = "nightly"
  description  = "🌌 Nightly builds of Artichoke Ruby"
  homepage_url = "https://github.com/artichoke/nightly/releases/latest"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "nightly",
    "nightly-build",
    "ruby",
    "rust",
    "rust-application",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "playground" {
  name         = "playground"
  description  = "🎡 Artichoke Ruby Wasm Playground"
  homepage_url = "https://artichoke.run/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "playground",
    "programming-language",
    "ruby",
    "rust",
    "rust-application",
    "wasm",
    "webassembly",
  ]

  pages {
    cname = "artichoke.run"
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "project_infrastructure" {
  name        = "project-infrastructure"
  description = "🛠 Infrastructure as code for the Artichoke open source project"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "infrastructure-as-code",
    "meta",
    "terraform",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "rand_mt" {
  name         = "rand_mt"
  description  = "🌪 Mersenne Twister implementation backed by rand_core"
  homepage_url = "https://crates.io/crates/rand_mt"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "mersenne-twister",
    "no-std",
    "rand",
    "random",
    "rng",
    "rust",
    "rust-crate",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "roe" {
  name         = "roe"
  description  = "🍣 Unicode case converters"
  homepage_url = "https://crates.io/crates/roe"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
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

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "rubyconf" {
  name         = "rubyconf"
  description  = "📽 RubyConf presentations"
  homepage_url = "https://artichoke.github.io/rubyconf/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
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

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "rubyconf2019_artichoke_run" {
  name         = "rubyconf2019.artichoke.run"
  description  = "📸 A snapshot of artichoke.run that runs the playground as of RubyConf 2019"
  homepage_url = "https://rubyconf2019.artichoke.run/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "playground",
    "programming-language",
    "ruby",
    "rust",
    "rust-application",
    "snapshot",
    "wasm",
    "webassembly",
  ]

  pages {
    cname = "rubyconf2019.artichoke.run"
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "strudel" {
  name         = "strudel"
  description  = "🥐 🥮 Rust port and drop-in replacement for the `st_hash` C hash table library"
  homepage_url = "https://artichoke.github.io/strudel/strudel/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "c",
    "ffi",
    "hashmap",
    "ruby",
    "rust",
    "rust-crate",
  ]

  pages {
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository" "www_artichokeruby_org" {
  name         = "www.artichokeruby.org"
  description  = "🌐 Artichoke Ruby project website"
  homepage_url = "https://www.artichokeruby.org/"

  visibility = "public"

  has_downloads = true
  has_issues    = true
  has_projects  = false
  has_wiki      = false

  delete_branch_on_merge = true
  vulnerability_alerts   = true

  topics = [
    "artichoke",
    "gh-pages",
    "project-website",
    "static-site",
  ]

  pages {
    cname = "www.artichokeruby.org"
    source {
      branch = "gh-pages"
      path   = "/"
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
