resource "azurerm_iothub" "pihub" {
  name                = "pihub-${var.student_id}"
  resource_group_name = data.azurerm_resource_group.sandbox.name
  location            = var.location

  sku {
    name     = "S1"
    capacity = "1"
  }
}

data "azurerm_iothub_shared_access_policy" "pihub_policy" {
  name = "iothubowner"
  resource_group_name = data.azurerm_resource_group.sandbox.name
  iothub_name = azurerm_iothub.pihub.name
}
