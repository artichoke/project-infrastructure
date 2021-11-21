---
name: Audit
"on":
  push:
    branches:
      - trunk
  pull_request:
    branches:
      - trunk
  schedule:
    - cron: "0 0 * * TUE"
jobs:
  js:
    name: Audit JS Dependencies
    if: ${has_npm_audit}
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install Nodejs toolchain
        run: npm ci

      - name: npm audit
        run: npm audit

  ruby:
    name: Audit Ruby Dependencies
    if: ${has_bundler_audit}
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install Ruby toolchain
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: ".ruby-version"
          bundler-cache: true

      - name: bundler-audit
        run: bundle exec bundle-audit check --update

  rust:
    name: Audit Rust Dependencies
    if: ${has_cargo_deny}
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Install Rust toolchain
        uses: actions-rs/toolchain@v1
        with:
          toolchain: nightly
          profile: minimal
          override: true

      - name: Generate Cargo.lock
        run: |
          if [[ ! -f "Cargo.lock" ]]; then
            cargo generate-lockfile --verbose
          fi

      - name: Setup cargo-deny
        run: |
          release_base="https://github.com/EmbarkStudios/cargo-deny/releases/download"
          version="${cargo_deny_version}"
          cargo_deny_tarball="$release_base/$version/cargo-deny-$version-x86_64-unknown-linux-musl.tar.gz"
          echo "Downloading cargo-deny $version from $cargo_deny_tarball."
          curl -sL "$cargo_deny_tarball" | sudo tar xvz -C /usr/local/bin/ --strip-components=1

      - name: cargo-deny version
        run: cargo-deny --version

      - name: Run cargo-deny
        run: cargo-deny --locked check --show-stats