variable "server_name" {
  type = string
}

variable "database_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "azuread_admin_login" {
  description = "Azure AD admin display name / UPN."
  type        = string
}

variable "azuread_admin_object_id" {
  description = "Azure AD admin object ID."
  type        = string
}

variable "sku_name" {
  type    = string
  default = "Basic"
}

variable "max_size_gb" {
  type    = number
  default = 2
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
