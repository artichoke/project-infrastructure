variable "zone_id" {
  description = "The id of the Route53 zone to create DKIM records in"
  type        = string
}

variable "dkim_record" {
  description = "The DKIM TXT record value"
  type        = string

  validation {
    condition     = substr(var.dkim_record, 0, length("v=DKIM1; k=rsa; p=")) == "v=DKIM1; k=rsa; p="
    error_message = "Include the full DKIM TXT record including 'v=DKIM1; k=rsa; p='."
  }
}
