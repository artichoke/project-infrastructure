module "artichoke_github_pages_global" {
  source = "./modules/global"

  plan  = var.plan
  phase = "global"
}
