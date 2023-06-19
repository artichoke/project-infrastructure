data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "_github-pages-challenge-${var.github_organization}.${var.domain}"
  type    = "TXT"
  ttl     = "3600"

  records = [var.challenge]

  lifecycle {
    prevent_destroy = true
  }
}
