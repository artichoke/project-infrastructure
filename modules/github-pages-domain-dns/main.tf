data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

# The given site is hosted on GitHub Pages at apex and www.
#
# Set up DNS to point to GitHub Pages and handle the redirect from the apex
# domain to `www`.
#
# https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

resource "aws_route53_record" "apex_ipv4" {
  zone_id = aws_route53_zone.this.zone_id
  name    = aws_route53_zone.this.name
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

resource "aws_route53_record" "apex_ipv6" {
  zone_id = aws_route53_zone.this.zone_id
  name    = aws_route53_zone.this.name
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

resource "aws_route53_record" "www_cname" {
  zone_id = aws_route53_zone.this.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = "300"

  records = ["${var.github_organization}.github.io"]

  lifecycle {
    prevent_destroy = true
  }
}
