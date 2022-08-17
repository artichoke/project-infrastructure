output "name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}

output "cert_arn" {
  description = "The ARN of the created ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "cloudfront_domain_name" {
  description = "The domain name corresponding to the CloudFront distribution"
  value       = aws_cloudfront_distribution.website.domain_name
}
