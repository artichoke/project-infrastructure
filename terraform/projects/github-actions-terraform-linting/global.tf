module "github_actions_terraform_linting_global" {
  source = "./modules/global"

  plan  = var.plan
  phase = "global"
}
