output "server_id" {
  value = azurerm_mssql_server.this.id
}

output "server_fqdn" {
  value = azurerm_mssql_server.this.fully_qualified_domain_name
}

output "database_name" {
  value = azurerm_mssql_database.this.name
}

output "admin_password_secret_name" {
  description = "Key Vault secret name holding the SQL admin password."
  value       = azurerm_key_vault_secret.sql_admin_password.name
}