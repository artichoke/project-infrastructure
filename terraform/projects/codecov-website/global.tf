module "codecov_website_global" {
  source = "./modules/global"

  plan  = var.plan
  phase = "global"

  providers = {
    aws           = aws
    aws.us_east_1 = aws.us_east_1
  }
}
