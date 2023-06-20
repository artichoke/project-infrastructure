output "cert_arn" {
  description = "The ARN of the created ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "cloudfront_domain_name" {
  description = "The domain name corresponding to the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}
