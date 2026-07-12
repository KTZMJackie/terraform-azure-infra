variable "name_prefix" {
  type = string
}

variable "app_name" {
  description = "Globally unique Web App name."
  type        = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "sku_name" {
  description = "App Service Plan SKU. B1 is a cheap always-on tier."
  type        = string
  default     = "B1"
}

variable "always_on" {
  type    = bool
  default = true
}

variable "app_subnet_id" {
  type = string
}

variable "vnet_id" {
  type = string
}

variable "private_endpoint_subnet_id" {
  type = string
}

variable "app_insights_connection_string" {
  type      = string
  sensitive = true
}

variable "key_vault_id" {
  type = string
}

variable "key_vault_uri" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}