output "name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.this.id
}

output "arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.this.arn
}
