output "site_verification" {
  value = [
    for key, verification in module.domain_data.google_site_verification_keys : {
      key                    = key,
      site_verification_keys = verification.site_verification_keys,
    }
  ]
}
