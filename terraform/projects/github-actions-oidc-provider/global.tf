module "github_actions_oidc_provider_global" {
  source = "./modules/global"

  plan  = var.plan
  phase = "global"
}
