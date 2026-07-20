#!/bin/bash

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <dev|prod>"
    exit 1
fi

ENV=$1

TERRAFORM_DIR="terraform/environments/${ENV}"
INVENTORY_FILE="ansible/inventory/hosts.ini"
KEY_FILE="../terraform/environments/${ENV}/project.pem"

PUBLIC_IP=$(terraform -chdir=${TERRAFORM_DIR} output -raw public_ip)

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