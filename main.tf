resource "azurerm_resource_group" "infra-rg" {
  location = var.location
  name     = var.rg-name
}

module "networking" {
  source  = "./modules/networking"
  rg-name = var.rg-name  # Pass the variable to the module
}
