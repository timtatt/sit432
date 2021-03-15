
resource "azurerm_iothub_dps" "pihub_dps" {
  location = var.location
  name = "pihub-${var.student_id}-dps"
  resource_group_name = var.resource_group_name

  linked_hub {
    connection_string = data.azurerm_iothub_shared_access_policy.pihub_policy.primary_connection_string
    location = azurerm_iothub.pihub.location
    allocation_weight = "1"
    apply_allocation_policy = true
  }

  sku {
    name = "S1"
    capacity = "1"
  }
}

resource "azurerm_iothub_dps_certificate" "dps_root" {
  name = "iothub-dps-root"
  resource_group_name = data.azurerm_resource_group.sandbox.name
  iot_dps_name = azurerm_iothub_dps.pihub_dps.name

  certificate_content = filebase64("./certificates/certs/azure-iot-test-only.root.ca.cert.pem")
}

resource "null_resource" "verify_dps_certificate" {
  provisioner "local-exec" {
    command = "python3 verify_certificate.py ${azurerm_iothub_dps.pihub_dps.name} ${data.azurerm_resource_group.sandbox.name} ${azurerm_iothub_dps_certificate.dps_root.name}"
    working_dir = "scripts"
  }

  depends_on = [
    azurerm_iothub_dps.pihub_dps,
    data.azurerm_resource_group.sandbox,
    azurerm_iothub_dps_certificate.dps_root
  ]

  triggers = {
    dps_root_name = azurerm_iothub_dps_certificate.dps_root.name
  }
}

resource "null_resource" "enrollment_group" {
  provisioner "local-exec" {
    command = "python3 create_enrollment_group.py ${azurerm_iothub_dps.pihub_dps.name} ${data.azurerm_resource_group.sandbox.name} iothub-devices ${azurerm_iothub_dps_certificate.dps_root.name}"
    working_dir = "scripts"
  }

  depends_on = [
    null_resource.verify_dps_certificate
  ]

  triggers = {
    dps_root_name = azurerm_iothub_dps_certificate.dps_root.name
  }
}
