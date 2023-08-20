# Domains

## Domain Names

| Domain            | Registrar               | DNS             | DNSSEC? | MX Records[^1]? |
| ----------------- | ----------------------- | --------------- | ------- | --------------- |
| artichoke.run     | Amazon Route 53 Domains | Amazon Route 53 | ❌      | ❌              |
| artichokeruby.com | Amazon Route 53 Domains | Amazon Route 53 | ❌      | ❌              |
| artichokeruby.net | Amazon Route 53 Domains | Amazon Route 53 | ❌      | ❌              |
| artichokeruby.org | Google Domains          | Google Domains  | ❌      | ✅              |
| artichokeruby.run | Amazon Route 53 Domains | Amazon Route 53 | ❌      | ❌              |

[^1]: MX records are also linked to a Google Workspace account.

## Web Properties

| Property                     | DNS                                | Description                         | HTTPS? | HSTS[^2]? |
| ---------------------------- | ---------------------------------- | ----------------------------------- | ------ | --------- |
| [artichoke.run]              | A and AAAA records to GitHub Pages | Wasm playground                     | ✅     | ❌        |
| [www.artichoke.run]          | CNAME to GitHub Pages              | Wasm playground redirect            | ✅     | ❌        |
| [rubyconf2019.artichoke.run] | CNAME to GitHub Pages              | Snapshot of the Wasm playground[^3] | ✅     | ❌        |
| [artichokeruby.com]          | CloudFront domain redirect         | Project website redirect            | ✅     | ✅        |
| [www.artichokeruby.com]      | CloudFront domain redirect         | Project website redirect            | ✅     | ✅        |
| [artichokeruby.org]          | Google-managed redirect            | Project website redirect            | ✅     | ❌        |
| [www.artichokeruby.org]      | CNAME to GitHub Pages              | Project website                     | ✅     | ❌        |
| [codecov.artichokeruby.org]  | CNAME to CloudFront distribution   | Code coverage reports               | ✅     | ✅        |
| [artichokeruby.net]          | CloudFront domain redirect         | Project website redirect            | ✅     | ✅        |
| [www.artichokeruby.net]      | CloudFront domain redirect         | Project website redirect            | ✅     | ✅        |
| [artichokeruby.run]          | CloudFront domain redirect         | Wasm playground website redirect    | ✅     | ✅        |
| [www.artichokeruby.run]      | CloudFront domain redirect         | Wasm playground website redirect    | ✅     | ✅        |

[artichoke.run]: https://artichoke.run/
[www.artichoke.run]: https://www.artichoke.run/
[rubyconf2019.artichoke.run]: https://rubyconf2019.artichoke.run/
[artichokeruby.com]: https://artichokeruby.com/
[www.artichokeruby.com]: https://www.artichokeruby.com/
[artichokeruby.org]: https://artichokeruby.org/
[www.artichokeruby.org]: https://www.artichokeruby.org/
[codecov.artichokeruby.org]: https://codecov.artichokeruby.org/
[artichokeruby.net]: https://artichokeruby.net/
[www.artichokeruby.net]: https://www.artichokeruby.net/
[artichokeruby.run]: https://artichokeruby.run/
[www.artichokeruby.run]: https://www.artichokeruby.run/

[^2]: Property sets [HTTP Strict Transport Security][hsts-explainer] headers.
[^3]:
    The playground snapshot at <https://rubyconf2019.artichoke.run> is used by
    RubyConf 2019 presentation at <https://artichoke.github.io/rubyconf/2019/>,
    which depends on Artichoke gems and embedding behavior present in this
    legacy version of the playground.

[hsts-explainer]:
  https://infosec.mozilla.org/guidelines/web_security#http-strict-transport-security
