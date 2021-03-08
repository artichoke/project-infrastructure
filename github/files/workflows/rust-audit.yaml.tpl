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
  rust:
    name: Audit Rust Dependencies
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

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
        run: cargo-deny check --show-stats
