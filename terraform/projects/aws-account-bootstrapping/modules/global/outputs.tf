output "account_id" {
  description = "The AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}
