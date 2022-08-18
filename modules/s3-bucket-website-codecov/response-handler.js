function handler(event) {
  var response = event.response;
  var headers = response.headers;

  // Prevent user agents from caching responses from this CloudFront
  // distribution.
  //
  // Per a request to <https://github.com/artichoke/strftime-ruby/workflows/CI/badge.svg>,
  // badges should return a `Cache-Control: no-cache` header. This header
  // prevents GitHub's camo servers from caching README badges.
  headers["cache-control"] = { value: "no-cache" };

  // Web security headers

  // https://infosec.mozilla.org/guidelines/web_security#http-strict-transport-security
  headers["strict-transport-security"] = { value: "max-age=63072000" };

  // https://infosec.mozilla.org/guidelines/web_security#content-security-policy
  // https://infosec.mozilla.org/guidelines/web_security#x-frame-options
  headers["content-security-policy"] = {
    value:
      "frame-ancestors 'none'; style-src 'self' https://cdn.jsdelivr.net/ 'nonce-b77e5ce9ed'; img-src 'self'; object-src 'none'; script-src 'none'; trusted-types; require-trusted-types-for 'script';",
  };

  // https://infosec.mozilla.org/guidelines/web_security#referrer-policy
  headers["referrer-policy"] = { value: "no-referrer" };

  // https://infosec.mozilla.org/guidelines/web_security#x-content-type-options
  headers["x-content-type-options"] = { value: "nosniff" };

  // https://infosec.mozilla.org/guidelines/web_security#x-frame-options
  headers["x-frame-options"] = { value: "DENY" };

  // https://infosec.mozilla.org/guidelines/web_security#x-xss-protection
  headers["x-xss-protection"] = { value: "1; mode=block" };

  return response;
}
