import sys
import os
from az.cli import az

dps_name, rg_name, cert_name = sys.argv[1:]

certificate_list = az(f"iot dps certificate list --dps-name {dps_name} --resource-group {rg_name}")[1]
certificate = certificate_list['value'][0]

if certificate['properties']['isVerified'] == True:
    print('Certificate is verified')
    exit()

print("Generating verification code")
certificate_details = az(f"iot dps certificate generate-verification-code --dps-name {dps_name} --resource-group {rg_name} --certificate-name {cert_name} --etag {certificate['etag']}")[1]

print("Generating verification certificate")
os.system(f"cd ./../certificates && ./certGen.sh create_verification_certificate {certificate_details['properties']['verificationCode']}")

print("Uploading verification certificate")
verification_response = az(f"iot dps certificate verify --dps-name {dps_name} --resource-group {rg_name} --certificate-name {cert_name} --path ./../certificates/certs/verification-code.cert.pem --etag {certificate_details['etag']}")
exit(verification_response[0])