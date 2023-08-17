data "aws_route53_zone" "this" {
  zone_id = var.zone_id
}

# https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site

resource "aws_route53_record" "www_cname" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.subdomain
  type    = "CNAME"
  ttl     = "300"

  records = ["${var.github_organization}.github.io"]

  lifecycle {
    prevent_destroy = true
  }
}
