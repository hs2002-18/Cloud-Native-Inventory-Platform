#!/bin/bash

set -e

PROJECT_NAME="inventory-platform"
NAMESPACE="inventory-platform"
MONITORING_NAMESPACE="monitoring"
IMAGE_NAME="inventory-platform:v1"

echo "========================================"
echo " Cloud Native Inventory Platform Setup"
echo "========================================"

echo ""
echo "[1/10] Starting Docker..."
sudo systemctl start docker

echo ""
echo "[2/10] Creating Kind cluster..."
kind create cluster --name ${PROJECT_NAME}

echo ""
echo "[3/10] Installing Metrics Server..."
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo ""
echo "Waiting for Metrics Server deployment..."
kubectl rollout status deployment/metrics-server -n kube-system

echo ""
echo "Patching Metrics Server..."

kubectl patch deployment metrics-server \
-n kube-system \
--type='json' \
-p='[
{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"},
{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname"}
]'

echo ""
echo "Restarting Metrics Server..."

kubectl rollout restart deployment metrics-server -n kube-system

kubectl rollout status deployment metrics-server -n kube-system

echo ""
echo "[4/10] Building Docker image..."

docker build -t ${IMAGE_NAME} .

echo ""
echo "[5/10] Loading image into Kind..."

kind load docker-image ${IMAGE_NAME} --name ${PROJECT_NAME}

echo ""
echo "[6/10] Creating namespace..."

kubectl create namespace ${NAMESPACE}

echo ""
echo "[7/10] Deploying Inventory Platform..."

helm install inventory ./helm/inventory-platform \
--namespace ${NAMESPACE}

echo ""
echo "Waiting for deployment..."

kubectl rollout status deployment/inventory-inventory-platform \
-n ${NAMESPACE}

echo ""
echo "[8/10] Adding Helm repositories..."

helm repo add prometheus https://prometheus-community.github.io/helm-charts >/dev/null 2>&1 || true
helm repo update

echo ""
echo "[9/10] Installing Prometheus..."

helm install prometheus prometheus-community/prometheus \
--namespace ${MONITORING_NAMESPACE} \
--create-namespace

echo ""
echo "Waiting for Prometheus..."

kubectl rollout status deployment/prometheus-server \
-n ${MONITORING_NAMESPACE}

echo ""
echo "[10/10] Verifying installation..."

kubectl get nodes

echo ""

kubectl get pods -n ${NAMESPACE}

echo ""

kubectl get pods -n ${MONITORING_NAMESPACE}

echo ""

echo "========================================"
echo " Setup Complete!"
echo "========================================"

echo ""
echo "Run the following commands:"
echo ""
echo "Application:"
echo "kubectl port-forward svc/inventory-inventory-platform 8000:8000 -n inventory-platform"
echo ""
echo "Prometheus:"
echo "kubectl port-forward svc/prometheus-server 9090:80 -n monitoring"
echo ""
echo "Grafana will be installed after Terraform deployment."