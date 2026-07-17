#!/bin/bash

set -e

PROJECT_NAME="inventory-platform"

echo "========================================"
echo " Cleaning Local Environment"
echo "========================================"

echo ""
echo "Deleting Kind cluster..."

kind delete cluster --name ${PROJECT_NAME}

echo ""
echo "Removing Docker image..."

docker rmi inventory-platform:v1 || true

echo ""
echo "Cleanup Complete."