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