#!/bin/bash

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./init.sh <dev|prod>"
    exit 1
fi

cd "$(dirname "$0")/../environments/$ENVIRONMENT"

terraform init -backend-config=backend.hcl