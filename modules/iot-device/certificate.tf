resource "null_resource" "create_certificate" {
  provisioner "local-exec" {
    command = "python3 ${path.module}/../../scripts/create_device_certificate.py"
  }
}