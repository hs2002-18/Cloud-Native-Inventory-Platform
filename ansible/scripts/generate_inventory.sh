#!/bin/bash

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 <dev|prod> <public_ip>"
    exit 1
fi

ENV=$1
PUBLIC_IP=$2

INVENTORY_FILE="ansible/inventory/hosts.ini"
KEY_FILE="../terraform/environments/${ENV}/project.pem"

cat > "${INVENTORY_FILE}" <<EOF
[inventory_servers]
inventory-server ansible_host=${PUBLIC_IP}

[inventory_servers:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=${KEY_FILE}
EOF

echo "Inventory generated successfully."
echo
cat "${INVENTORY_FILE}"