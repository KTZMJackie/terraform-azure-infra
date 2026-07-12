output "resource_group_name" {
  value = module.resource_group.name
}

output "app_service_hostname" {
  value = module.app_service.default_hostname
}

output "key_vault_uri" {
  value = module.key_vault.uri
}

output "sql_server_fqdn" {
  value = module.sql.server_fqdn
}

output "storage_account_name" {
  value = module.storage.name
}