module "aws_account_bootstrapping_global" {
  source = "./modules/global"

  plan   = var.plan
  region = var.region
  phase  = "global"
}
