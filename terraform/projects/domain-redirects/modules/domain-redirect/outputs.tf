output "cert_arn" {
  description = "The ARN of the created ACM certificate"
  value       = module.cert.cert_arn
}

output "cloudfront_domain_name" {
  description = "The domain name corresponding to the CloudFront distribution"
  value       = aws_cloudfront_distribution.this.domain_name
}

output "bucket_name" {
  description = "The name of the S3 bucket used for redirection"
  value       = aws_s3_bucket.this.bucket
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket used for redirection"
  value       = aws_s3_bucket.this.arn
}
