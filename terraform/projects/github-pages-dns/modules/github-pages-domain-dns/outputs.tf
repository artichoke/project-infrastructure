output "domains" {
  value = var.include_apex ? concat(
    [data.aws_route53_zone.zone.name], [for subdomain in var.subdomains : "${subdomain}.${data.aws_route53_zone.zone.name}"]
  ) : [for subdomain in var.subdomains : "${subdomain}.${data.aws_route53_zone.zone.name}"]
}
