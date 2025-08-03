# The given site is hosted on GitHub Pages.
#
# https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

data "aws_route53_zone" "this" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "ipv4" {
  for_each = var.include_apex ? toset(["apex"]) : toset([])

  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "A"
  ttl     = "300"

  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "ipv6" {
  for_each = var.include_apex ? toset(["apex"]) : toset([])

  zone_id = data.aws_route53_zone.this.zone_id
  name    = data.aws_route53_zone.this.name
  type    = "AAAA"
  ttl     = "300"

  records = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153",
  ]

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "cname" {
  for_each = toset(var.subdomains)

  zone_id = data.aws_route53_zone.this.zone_id
  name    = each.key
  type    = "CNAME"
  ttl     = "300"

  records = ["${var.github_organization}.github.io"]

  lifecycle {
    prevent_destroy = true
  }
}
