import os
import shutil
import sys

device_name = sys.argv[1]
cert_file_path = f'./../certificates/certs/{device_name}.cert.pfx'

if os.path.exists(cert_file_path):
    os.remove(cert_file_path)

os.system(f"cd ./../certificates/ && ./certGen.sh create_device_certificate {device_name}")

os.remove('./../certificates/certs/new-device.cert.pem')
shutil.move('./../certificates/certs/new-device.cert.pfx', cert_file_path)