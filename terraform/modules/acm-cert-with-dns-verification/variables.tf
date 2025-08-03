variable "zone_id" {
  description = "The id of the Route53 zone to create TXT records in"
  type        = string
}

variable "domains" {
  description = "The domains the certificate is valid for (SANs). The first domain in the list is the primary"
  type        = list(string)
}
