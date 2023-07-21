variable "CISCO_ACI_TERRAFORM_USERNAME" {
  type        = string
  description = "MAPS TO ENVIRONMENTAL VARIABLE TF_VAR_CISCO_ACI_TERRAFORM_USERNAME"
}

variable "CISCO_ACI_TERRAFORM_PASSWORD" {
  type        = string
  description = "MAPS TO ENVIRONMENTAL VARIABLE TF_VAR_CISCO_ACI_TERRAFORM_PASSWORD"
  sensitive   = true
}

variable "CISCO_ACI_APIC_IP_ADDRESS" {
  type        = string
  description = "MAPS TO ENVIRONMENTAL VARIABLE TF_VAR_CISCO_ACI_APIC_IP_ADDRESS"
}
