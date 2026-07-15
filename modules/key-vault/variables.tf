variable "name" {
  description = "Globally unique Key Vault name (3-24 chars)."
  type        = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "deployer_object_id" {
  description = "Object ID of whoever runs Terraform (gets Secrets Officer)."
  type        = string
}

variable "vnet_id" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "allowed_ip_addresses" {
  description = "Public IPs allowed through the Key Vault firewall (e.g. the deployer's IP). Empty = fully private."
  type        = list(string)
  default     = []
}
