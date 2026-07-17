#!/bin/bash

set -e

ENVIRONMENT=$1

if [ -z "$ENVIRONMENT" ]; then
    echo "Usage: ./validate.sh <dev|prod>"
    exit 1
fi

cd "$(dirname "$0")/../environments/$ENVIRONMENT"

terraform validate -backend-config=backend.hcl