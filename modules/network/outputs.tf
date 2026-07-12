output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "app_subnet_id" {
  description = "Subnet ID for App Service VNet integration."
  value       = azurerm_subnet.app.id
}

output "private_endpoint_subnet_id" {
  description = "Subnet ID hosting private endpoints."
  value       = azurerm_subnet.private_endpoints.id
}