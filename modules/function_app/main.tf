#storage dependency for function app
resource "azurerm_storage_account" "storage" {
  name                     = "funcappstrinstance001"
  resource_group_name      = var.rg-name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

#service plan for function app
resource "azurerm_service_plan" "service-plan-001" {
  name                = "funcappserviceplan001"
  resource_group_name = var.rg-name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "S1"
}

#function app resource
resource "azurerm_linux_function_app" "function-app" {
  name                = "funcappinstance001"
  resource_group_name = var.rg-name
  location            = var.location

  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage. primary_access_key
  service_plan_id            = azurerm_service_plan.service-plan-001.id

  site_config {
    always_on = true
    application_stack {
      python_version = "3.11"
    }
  }

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "python"   # Set Python as the worker runtime
    "WEBSITE_RUN_FROM_PACKAGE" = "1"        # Enables deployment from a package
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = "1"  # Ensures dependencies are installed
  }
}

#private endpoint resource for private connectivity
resource "azurerm_private_endpoint" "private-endpoint" {
  name                = "functionapp-private-endpoint"
  location            = var.location
  resource_group_name = var.rg-name
  subnet_id           = var.subnet_id #private endpoint Nic will be hosted in the dedicated spoke subnet

  private_service_connection {
    name                           = "funcprivateserviceconnection-001"
    private_connection_resource_id = azurerm_linux_function_app.function-app.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  private_dns_zone_group {
    name                 = "my-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.private-dns.id]
  }
}

resource "azurerm_private_dns_zone" "private-dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.rg-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "example-link"
  resource_group_name   = var.rg-name
  private_dns_zone_name = azurerm_private_dns_zone.private-dns.name
  virtual_network_id    = var.spoke_vnet_id
}