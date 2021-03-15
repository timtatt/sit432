import sys
import os
from az.cli import az

dps_name, rg_name, enrollment_id, ca_name = sys.argv[1:]
enrollment_groups = az(f"iot dps enrollment-group list -g {rg_name} --dps-name {dps_name}")[1]
print(enrollment_groups)

if len(enrollment_groups) == 0:
    enrollment_group = az(f"iot dps enrollment-group create -g {rg_name} --dps-name {dps_name} --enrollment-id {enrollment_id} --ca-name {ca_name}")
    print(enrollment_group[1])
    exit(enrollment_group[0])