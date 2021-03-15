resource "null_resource" "create_certificate" {
  provisioner "local-exec" {
    command = "cd ${path.module}/../../scripts/ && python3 create_device_certificate.py ${var.device_name}"
  }
}

data "local_file" "certificate" {
  filename = "${path.module}/../../certificates/certs/${var.device_name}.cert.pfx"
  depends_on = [null_resource.create_certificate]
}