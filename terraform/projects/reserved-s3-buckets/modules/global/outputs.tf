output "buckets" {
  value = [
    for bucket in module.reserved_s3_bucket : {
      arn  = bucket.arn,
      name = bucket.name,
    }
  ]
}
