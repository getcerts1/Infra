resource "azurerm_resource_group" "infra-rg" {
  location = var.location
  name     = var.rg-name
}


module "function_app" {
  source        = "./modules/function_app"
  rg-name       = azurerm_resource_group.infra-rg.name
  location      = var.location
  subnet_id     = module.networking.private_endpoint_subnet_id
  spoke_vnet_id = module.networking.spoke_vnet_id
}

module "networking" {
  source  = "./modules/networking"
  rg-name = azurerm_resource_group.infra-rg.name
}