data "aws_route53_zone" "zone" {
  for_each = toset([for conf in module.domain_data.domain_redirects : conf.domain])
  name     = each.key
}

module "redirect_bucket_access_logs" {
  source = "../../../../modules/access-logs-s3-bucket"

  bucket = "artichoke-forge-redirect-bucket-logs"
}

module "domain_redirect" {
  for_each = { for conf in module.domain_data.domain_redirects : substr(md5("${conf.domain}-redirect-to-${conf.redirect_to}"), 0, 8) => conf }
  source   = "../domain-redirect"

  access_logs_bucket = module.redirect_bucket_access_logs.name
  zone_id            = data.aws_route53_zone.zone[each.value.domain].zone_id
  redirect_to        = each.value.redirect_to
  include_apex       = each.value.include_apex
  subdomains         = each.value.subdomains
  suffix             = each.key

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
