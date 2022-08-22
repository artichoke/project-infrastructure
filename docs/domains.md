# Domains

## Domain Names

| Domain            | Registrar      | DNS            | DNSSEC? | MX Records[^1]? |
| ----------------- | -------------- | -------------- | ------- | --------------- |
| artichoke.dev     | Google Domains | None           | ✅      | ❌              |
| artichoke.run     | Google Domains | Google Domains | ✅      | ❌              |
| artichokeruby.com | Google Domains | Google Domains | ✅      | ❌              |
| artichokeruby.dev | Google Domains | None           | ✅      | ❌              |
| artichokeruby.net | Google Domains | Google Domains | ✅      | ❌              |
| artichokeruby.org | Google Domains | Google Domains | ✅      | ✅              |
| artichokeruby.run | Google Domains | Google Domains | ✅      | ❌              |

[^1]: MX records are also linked to a Google Workspace account.

## Web Properties

| Property                   | DNS                                | Description                         | HTTPS? | HSTS[^2]? |
| -------------------------- | ---------------------------------- | ----------------------------------- | ------ | --------- |
| artichoke.run              | A and AAAA records to GitHub Pages | Wasm playground                     | ✅     | ❌        |
| www.artichoke.run          | CNAME to GitHub Pages              | Wasm playground redirect            | ✅     | ❌        |
| artichokeruby.com          | Google-managed redirect            | Project website redirect            | ✅     | ❌        |
| www.artichokeruby.com      | Google-managed redirect            | Project website redirect            | ✅     | ❌        |
| rubyconf2019.artichoke.run | CNAME to GitHub Pages              | Snapshot of the Wasm playground[^3] | ✅     | ❌        |
| artichokeruby.org          | Google-managed redirect            | Project website redirect            | ✅     | ❌        |
| codecov.artichokeruby.org  | CNAME to CloudFront distribution   | Code coverage reports               | ✅     | ✅        |
| www.artichokeruby.org      | CNAME to GitHub Pages              | Project website                     | ✅     | ❌        |
| artichokeruby.net          | Google-managed redirect            | Project website redirect            | ✅     | ❌        |
| www.artichokeruby.net      | Google-managed redirect            | Project website redirect            | ✅     | ❌        |
| artichokeruby.run          | Google-managed redirect            | Wasm playground website redirect    | ✅     | ❌        |
| www.artichokeruby.run      | Google-managed redirect            | Wasm playground website redirect    | ✅     | ❌        |

[^2]: Property sets [HTTP Strict Transport Security][hsts-explainer] headers.
[^3]:
    The playground snapshot at <https://rubyconf2019.artichoke.run> is used by
    RubyConf 2019 presentation at <https://artichoke.github.io/rubyconf/2019/>,
    which depends on Artichoke gems and embedding behavior present in this
    legacy version of the playground.

[hsts-explainer]:
  https://infosec.mozilla.org/guidelines/web_security#http-strict-transport-security
