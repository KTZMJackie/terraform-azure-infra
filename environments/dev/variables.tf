variable "project" {
  description = "Short project slug used in resource names."
  type        = string
}

variable "environment" {
  description = "Environment name (dev, prod)."
  type        = string
}

variable "location" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "app_subnet_prefix" {
  type = string
}

variable "pe_subnet_prefix" {
  type = string
}

variable "sql_sku_name" {
  type = string
}

variable "app_service_sku" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "key_vault_allowed_ips" {
  description = "Deployer public IPs allowed through the Key Vault firewall during apply."
  type        = list(string)
  default     = []
}

variable "storage_allow_shared_key" {
  description = "Allow storage shared-key auth during a laptop-based apply."
  type        = bool
  default     = false
}
