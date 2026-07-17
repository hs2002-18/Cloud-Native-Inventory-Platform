# Grafana

Grafana is intentionally not configured in the local Kind environment.

After the infrastructure is provisioned with Terraform and configured using Ansible, Grafana will be deployed on the Kubernetes cluster using the official Helm chart and connected to Prometheus for application and cluster monitoring.

Planned tasks:
- Install Grafana using Helm
- Configure Prometheus as the data source
- Create dashboards for:
  - FastAPI application metrics
  - Kubernetes cluster metrics
  - Node resource utilization
  - Horizontal Pod Autoscaler (HPA)