terraform {
  required_version = ">= 1.5"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
  # No backend block on purpose: bootstrap uses LOCAL state, because it
  # creates the storage account that everything else uses as its backend.
}

provider "azurerm" {
  features {}
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-tfstate-${var.project}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "tfstate" {
  #checkov:skip=CKV_AZURE_59:State backend must be reachable from CI/CD runners over the public internet
  #checkov:skip=CKV2_AZURE_33:State backend uses network rules + AAD auth; a private endpoint would block public runners
  name                            = "st${var.project}tfstate${random_string.suffix.result}"
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 7
    }
  }
  tags = var.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}