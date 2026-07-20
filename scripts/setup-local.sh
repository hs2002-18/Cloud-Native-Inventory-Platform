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

sudo dockerd > /tmp/dockerd.log 2>&1 &

echo "Waiting for Docker..."

until docker info >/dev/null 2>&1; do
    sleep 2
done

echo "Docker started successfully."

echo ""
echo "[2/10] Creating Kind cluster..."

if kind get clusters | grep -q "^${PROJECT_NAME}$"; then
    echo "Kind cluster already exists."
else
    kind create cluster --name ${PROJECT_NAME}
fi

echo ""
echo "[3/10] Installing Metrics Server..."

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

echo ""
echo "Waiting for Metrics Server deployment to be created..."

kubectl wait \
  --for=condition=Available \
  deployment/metrics-server \
  -n kube-system \
  --timeout=120s || true

echo ""
echo "Patching Metrics Server..."

kubectl patch deployment metrics-server \
-n kube-system \
--type='json' \
-p='[
{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"},
{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname"}
]' || true

echo ""
echo "Restarting Metrics Server..."

kubectl rollout restart deployment metrics-server -n kube-system

echo ""
echo "Waiting for Metrics Server..."

kubectl rollout status deployment metrics-server -n kube-system

echo ""
echo "[4/10] Building Docker image..."

if docker image inspect ${IMAGE_NAME} >/dev/null 2>&1; then
    echo "Docker image ${IMAGE_NAME} already exists."
else
    docker build -t ${IMAGE_NAME} .
fi

echo ""
echo "[5/10] Loading image into Kind..."

kind load docker-image ${IMAGE_NAME} --name ${PROJECT_NAME}

echo ""
echo "[6/10] Creating namespace..."

kubectl create namespace ${NAMESPACE} \
--dry-run=client -o yaml | kubectl apply -f -

echo ""
echo "[7/10] Deploying Inventory Platform..."

helm upgrade --install inventory ./helm/inventory-platform \
--namespace ${NAMESPACE} \
--create-namespace

echo ""
echo "Waiting for deployment..."

kubectl rollout status deployment/inventory-inventory-platform \
-n ${NAMESPACE}

echo ""
echo "[8/10] Adding Helm repositories..."

helm repo add prometheus https://prometheus-community.github.io/helm-charts >/dev/null 2>&1 || true
helm repo add grafana https://grafana.github.io/helm-charts >/dev/null 2>&1 || true

helm repo update

echo ""
echo "[9/10] Installing Prometheus..."

echo "[9/10] Installing Prometheus..."

helm upgrade --install prometheus prometheus-community/prometheus \
  --namespace ${MONITORING_NAMESPACE} \
  --create-namespace

echo ""
echo "Waiting for Prometheus..."

kubectl rollout status deployment/prometheus-server \
  -n ${MONITORING_NAMESPACE}

echo "[10/10] Verifying installation..."

echo ""
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
echo "Grafana:"
echo "helm upgrade --install grafana grafana/grafana -n monitoring --create-namespace"
echo "kubectl port-forward svc/grafana 3000:80 -n monitoring"

echo ""
echo "Happy Kubernetes!"