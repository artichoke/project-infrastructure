data "aws_route53_zone" "zone" {
  zone_id = var.zone_id
}

resource "aws_route53_record" "this" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "google._domainkey"
  type    = "TXT"
  ttl     = "3600"

  # Per terraform docs[^1]:
  #
  # > To specify a single record value longer than 255 characters such as a TXT
  # record for DKIM, add \"\" inside the Terraform configuration string (e.g.,
  # `"first255characters\"\"morecharacters"`).
  #
  # [^1]: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record
  records = [replace(var.dkim_record, "/(.{254})/", "$1\" \"")]

  lifecycle {
    prevent_destroy = true
  }
}
