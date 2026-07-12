project           = "aztf"
environment       = "prod"
location          = "southeastasia"
address_space     = ["10.20.0.0/16"]
app_subnet_prefix = "10.20.1.0/24"
pe_subnet_prefix  = "10.20.2.0/24"

# Larger SKUs for production headroom.
sql_sku_name    = "S0"
app_service_sku = "P1v3"

tags = {
  owner = "jack"
}