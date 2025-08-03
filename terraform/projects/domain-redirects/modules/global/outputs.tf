output "redirects" {
  value = [
    for key, redirect in module.domain_redirect : {
      key                    = key,
      bucket_name            = redirect.bucket_name,
      bucket_arn             = redirect.bucket_arn,
      cloudfront_domain_name = redirect.cloudfront_domain_name,
      cert_arn               = redirect.cert_arn,
    }
  ]
}
