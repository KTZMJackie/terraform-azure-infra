variable "name_prefix" {
  description = "Prefix used to name network resources (e.g. aztf-dev)."
  type        = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "address_space" {
  description = "VNet address space."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "app_subnet_prefix" {
  type    = string
  default = "10.10.1.0/24"
}

variable "pe_subnet_prefix" {
  type    = string
  default = "10.10.2.0/24"
}

variable "tags" {
  type    = map(string)
  default = {}
}