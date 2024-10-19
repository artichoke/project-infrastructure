output "remote_state_bucket" {
  value = {
    arn  = module.remote_state.arn,
    name = module.remote_state.name,
  }
}
