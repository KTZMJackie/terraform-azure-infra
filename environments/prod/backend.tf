terraform {
  backend "azurerm" {
    container_name = "tfstate"
    key            = "prod/terraform.tfstate"
  }
}