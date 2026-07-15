resource "azurerm_key_vault" "this" {
  #checkov:skip=CKV_AZURE_189:Public access is disabled by default (allowlist empty); enabled only via an explicit deployer IP allowlist with default_action=Deny for break-glass deploys
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  rbac_authorization_enabled    = true
  purge_protection_enabled      = true
  soft_delete_retention_days    = 7
  public_network_access_enabled = length(var.allowed_ip_addresses) > 0

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = var.allowed_ip_addresses
  }

  tags = var.tags
}

# (2) Private DNS zone: makes the vault hostname resolve to a private IP.
resource "azurerm_private_dns_zone" "kv" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# (3) Link the DNS zone to our VNet so lookups inside it work.
resource "azurerm_private_dns_zone_virtual_network_link" "kv" {
  name                  = "${var.name}-kv-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.kv.name
  virtual_network_id    = var.vnet_id
  tags                  = var.tags
}

# (4) The private endpoint itself, placed in the PE subnet.
resource "azurerm_private_endpoint" "kv" {
  name                = "${var.name}-kv-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.private_endpoint_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${var.name}-kv-psc"
    private_connection_resource_id = azurerm_key_vault.this.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "vault"
    private_dns_zone_ids = [azurerm_private_dns_zone.kv.id]
  }
}

# Give whoever runs Terraform permission to manage secrets in this vault.
resource "azurerm_role_assignment" "deployer_secrets_officer" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = var.deployer_object_id
}