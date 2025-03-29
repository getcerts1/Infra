output "private_endpoint_subnet_id" {
  value = azurerm_subnet.private-endpoint-subnet.id
}

output "spoke_vnet_id" {
  value = azurerm_virtual_network.spoke-vnet.id
}
