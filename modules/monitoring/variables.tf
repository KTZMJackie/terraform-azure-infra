variable "name_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "retention_in_days" {
  description = "How long to keep logs."
  type        = number
  default     = 90
}

variable "tags" {
  type    = map(string)
  default = {}
}