output "app_name" {
  value = azurerm_linux_web_app.this.name
}

output "default_hostname" {
  value = azurerm_linux_web_app.this.default_hostname
}

output "principal_id" {
  description = "Managed identity principal ID of the web app."
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}