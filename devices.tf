module "device1" {
  source = "./modules/iot-device"
  device_name = "iothub-device1"

  depends_on = [null_resource.verify_dps_certificate]
}

module "device2" {
  source = "./modules/iot-device"
  device_name = "iothub-device2"

  depends_on = [module.device1]
}

module "device3" {
  source = "./modules/iot-device"
  device_name = "iothub-device3"

  depends_on = [module.device2]
}