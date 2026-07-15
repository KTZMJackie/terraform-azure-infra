variable "name" {
  description = "Globally unique storage account name (3-24 lowercase alphanumeric)."
  type        = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "replication_type" {
  description = "LRS (cheapest) up to GRS."
  type        = string
  default     = "LRS"
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
  description = "Public IPs allowed through the storage firewall during apply. Empty = fully private."
  type        = list(string)
  default     = []
}

variable "allow_shared_key" {
  description = "Allow shared-key auth (needed for laptop-based apply of blob properties). Default false = hardened."
  type        = bool
  default     = false
}
