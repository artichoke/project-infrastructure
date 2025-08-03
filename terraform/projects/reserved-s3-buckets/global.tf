module "reserved_s3_buckets_global" {
  source = "./modules/global"

  plan  = var.plan
  phase = "global"
}
