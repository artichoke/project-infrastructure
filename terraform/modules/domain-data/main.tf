locals {
  domains = [
    "artichoke.run",
    "artichokeruby.com",
    "artichokeruby.net",
    "artichokeruby.org",
    "artichokeruby.run",
  ]

  # DNS challenge credentials to show a GitHub Organization claims ownership of
  # a domain.
  domain_to_github_org_challenge = {
    "artichoke.run" = [
      {
        org       = "artichoke"
        domain    = "artichoke.run"
        challenge = "269dfad3e5"
      },
      {
        org       = "artichoke"
        domain    = "rubyconf2019.artichoke.run"
        challenge = "7334204bc9"
      },
      {
        org       = "artichoke"
        domain    = "www.artichoke.run"
        challenge = "cb003a6b0b"
      },
      {
        org       = "artichokeruby"
        domain    = "artichoke.run"
        challenge = "62c47d9852"
      },
      {
        org       = "artichokeruby"
        domain    = "rubyconf2019.artichoke.run"
        challenge = "45a5783abe"
      },
      {
        org       = "artichokeruby"
        domain    = "www.artichoke.run"
        challenge = "58c732d6b6"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "artichoke.run"
        challenge = "636dd41740"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "rubyconf2019.artichoke.run"
        challenge = "a5e31fdb89"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "www.artichoke.run"
        challenge = "0b0528b66d"
      },
    ]
    "artichokeruby.com" = [
      {
        org       = "artichoke"
        domain    = "artichokeruby.com"
        challenge = "b2f4638e51"
      },
      {
        org       = "artichoke"
        domain    = "www.artichokeruby.com"
        challenge = "2fec52406f"
      },
      {
        org       = "artichokeruby"
        domain    = "artichokeruby.com"
        challenge = "ca289d9cc6"
      },
      {
        org       = "artichokeruby"
        domain    = "www.artichokeruby.com"
        challenge = "4ed7a6a51e"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "artichokeruby.com"
        challenge = "52fff25586"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "www.artichokeruby.com"
        challenge = "2f65a1a84d"
      },
    ]
    "artichokeruby.net" = [
      {
        org       = "artichoke"
        domain    = "artichokeruby.net"
        challenge = "40284224b9"
      },
      {
        org       = "artichoke"
        domain    = "www.artichokeruby.net"
        challenge = "4970552f6c"
      },
      {
        org       = "artichokeruby"
        domain    = "artichokeruby.net"
        challenge = "7a2a1dc233"
      },
      {
        org       = "artichokeruby"
        domain    = "www.artichokeruby.net"
        challenge = "3113b923f8"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "artichokeruby.net"
        challenge = "98600a94a6"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "www.artichokeruby.net"
        challenge = "f82ad5d5e8"
      },
    ]
    "artichokeruby.org" = []
    "artichokeruby.run" = [
      {
        org       = "artichoke"
        domain    = "artichokeruby.run"
        challenge = "8c1ebf9fc6"
      },
      {
        org       = "artichoke"
        domain    = "www.artichokeruby.run"
        challenge = "f8dd1ad8a9"
      },
      {
        org       = "artichokeruby-org"
        domain    = "artichokeruby.run"
        challenge = "d99613e00f"
      },
      {
        org       = "artichokeruby-org"
        domain    = "www.artichokeruby.run"
        challenge = "6554401e36"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "artichokeruby.run"
        challenge = "5d7d7290b9"
      },
      {
        org       = "artichoke-ruby-org"
        domain    = "www.artichokeruby.run"
        challenge = "3e5409f8a9"
      },
    ]
  }

  # DNS challenge credentials to show a GitHub organization can publish GitHub
  # pages with the domain as a CNAME.
  domain_to_github_pages_challenge = {
    "artichoke.run"     = "485977220be94c7ea6d333d5011d0c"
    "artichokeruby.com" = "cef8b209bccd79f7df0f51b877bd9e"
    "artichokeruby.net" = "7da729a45019ca339d0cedce912c2e"
    "artichokeruby.run" = "50369d1a13ec11c0d9899705388810"
  }

  zones_with_redirect = [
    {
      zone        = "artichokeruby.com"
      apex        = true
      names       = ["www"]
      redirect_to = "https://www.artichokeruby.org"
    },
    {
      zone        = "artichokeruby.net"
      apex        = true
      names       = ["www"]
      redirect_to = "https://www.artichokeruby.org"
    },
    {
      zone        = "artichokeruby.org"
      apex        = true
      names       = []
      redirect_to = "https://www.artichokeruby.org"
    },
    {
      zone        = "artichokeruby.run"
      apex        = true
      names       = ["www"]
      redirect_to = "https://artichoke.run"
    },
  ]
}
