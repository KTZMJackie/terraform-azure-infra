variable "project" {
  description = "Short project slug (lowercase, no spaces)."
  type        = string
  default     = "aztf"
}

variable "location" {
  type    = string
  default = "southeastasia"
}

variable "tags" {
  type = map(string)
  default = {
    project   = "terraform-azure-infra"
    managedby = "terraform"
    component = "tfstate-backend"
  }
}