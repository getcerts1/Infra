resource "azurerm_virtual_network" "hub-vnet" {
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  name                = var.hub-vnet-name
  resource_group_name = var.rg-name
}

resource "azurerm_subnet" "app-gw-subnet" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = var.ApplicationGatewaySubnet-001
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.hub-vnet.name
}


resource "azurerm_virtual_network" "spoke-vnet" {
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  name                = var.spoke-vnet-name
  resource_group_name = var.rg-name
}

resource "azurerm_subnet" "funcapp-subnet" {
  address_prefixes     = ["10.1.0.0/24"]
  name                 = var.spoke-subnet-001
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.spoke-vnet.name
}

resource "azurerm_subnet" "private-endpoint-subnet" {
  address_prefixes     = ["10.1.1.0/24"]
  name                 = var.spoke-subnet-002
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.spoke-vnet.name
}

resource "azurerm_virtual_network_peering" "peering-connection" {
  name                      = "to-spoke"
  remote_virtual_network_id = azurerm_virtual_network.spoke-vnet.id
  resource_group_name       = var.rg-name
  virtual_network_name      = azurerm_virtual_network.hub-vnet.name
}