# Remote state in Azure Blob. Actual account name is passed at init time,
# so no environment-specific values sit in the code.
terraform {
  backend "azurerm" {
    container_name = "tfstate"
    key            = "dev/terraform.tfstate"
  }
}