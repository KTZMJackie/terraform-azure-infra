project           = "aztf"
environment       = "dev"
location          = "southeastasia"
address_space     = ["10.10.0.0/16"]
app_subnet_prefix = "10.10.1.0/24"
pe_subnet_prefix  = "10.10.2.0/24"

# Cost-aware SKUs for dev.
sql_sku_name    = "Basic"
app_service_sku = "B1"

tags = {
  owner = "jack"
}