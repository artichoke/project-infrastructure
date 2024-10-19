module "remote_state_global" {
  source = "./modules/global"

  plan  = var.plan
  phase = "global"
}
