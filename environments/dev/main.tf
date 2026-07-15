data "azurerm_client_config" "current" {}

locals {
  name_prefix = "${var.project}-${var.environment}"
  suffix      = random_string.suffix.result
  base_tags = merge(var.tags, {
    environment = var.environment
    project     = var.project
    managedby   = "terraform"
  })
}

resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

module "resource_group" {
  source   = "../../modules/resource-group"
  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.base_tags
}

module "network" {
  source              = "../../modules/network"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.resource_group.name
  address_space       = var.address_space
  app_subnet_prefix   = var.app_subnet_prefix
  pe_subnet_prefix    = var.pe_subnet_prefix
  tags                = local.base_tags
}

module "monitoring" {
  source              = "../../modules/monitoring"
  name_prefix         = local.name_prefix
  location            = var.location
  resource_group_name = module.resource_group.name
  tags                = local.base_tags
}

module "key_vault" {
  source                     = "../../modules/key-vault"
  name                       = "kv-${var.project}${var.environment}${local.suffix}"
  location                   = var.location
  resource_group_name        = module.resource_group.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  deployer_object_id         = data.azurerm_client_config.current.object_id
  allowed_ip_addresses       = var.key_vault_allowed_ips
  vnet_id                    = module.network.vnet_id
  private_endpoint_subnet_id = module.network.private_endpoint_subnet_id
  tags                       = local.base_tags
}

module "storage" {
  source                     = "../../modules/storage-account"
  allowed_ip_addresses       = var.key_vault_allowed_ips
  allow_shared_key           = var.storage_allow_shared_key
  name                       = "st${var.project}${var.environment}${local.suffix}"
  location                   = var.location
  resource_group_name        = module.resource_group.name
  vnet_id                    = module.network.vnet_id
  private_endpoint_subnet_id = module.network.private_endpoint_subnet_id
  tags                       = local.base_tags
}

module "sql" {
  source                     = "../../modules/sql-database"
  depends_on                 = [module.key_vault]
  server_name                = "sql-${var.project}-${var.environment}-${local.suffix}"
  database_name              = "appdb"
  location                   = var.location
  resource_group_name        = module.resource_group.name
  azuread_admin_login        = data.azurerm_client_config.current.object_id
  azuread_admin_object_id    = data.azurerm_client_config.current.object_id
  sku_name                   = var.sql_sku_name
  key_vault_id               = module.key_vault.id
  vnet_id                    = module.network.vnet_id
  private_endpoint_subnet_id = module.network.private_endpoint_subnet_id
  tags                       = local.base_tags
}

module "app_service" {
  source                         = "../../modules/app-service"
  name_prefix                    = local.name_prefix
  app_name                       = "app-${var.project}-${var.environment}-${local.suffix}"
  location                       = var.location
  resource_group_name            = module.resource_group.name
  sku_name                       = var.app_service_sku
  app_subnet_id                  = module.network.app_subnet_id
  vnet_id                        = module.network.vnet_id
  private_endpoint_subnet_id     = module.network.private_endpoint_subnet_id
  app_insights_connection_string = module.monitoring.app_insights_connection_string
  key_vault_id                   = module.key_vault.id
  key_vault_uri                  = module.key_vault.uri
  tags                           = local.base_tags
}