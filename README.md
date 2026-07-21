Cloud Native Inventory Platform
> End-to-end cloud-native deployment platform using Terraform, Ansible,
> Docker, Kubernetes (Kind), Helm, GitHub Actions, Prometheus and
> Grafana.
Features
Multi-environment infrastructure (dev/prod)
Terraform modular infrastructure
EC2 provisioning on AWS
Ansible server configuration
Docker image build
Kind Kubernetes cluster
Helm-based deployment
FastAPI Inventory application
Prometheus & Grafana monitoring
GitHub Actions CI/CD
Architecture
``` text
Developer
   │
GitHub ─────────────┐
   │                │
GitHub Actions      │
   │                │
Terraform ─────────▶ AWS EC2
                     │
                 Ansible
                     │
                  Docker
                     │
                    Kind
                     │
               Kubernetes
          ┌──────────┴──────────┐
      FastAPI App         Monitoring
                         ├─ Prometheus
                         └─ Grafana
```
Tech Stack
Category          Tools
---
Cloud             AWS EC2, IAM
IaC               Terraform
Configuration     Ansible
Containers        Docker
Orchestration     Kubernetes (Kind)
Package Manager   Helm
Backend           FastAPI
Monitoring        Prometheus, Grafana
CI/CD             GitHub Actions
Repository Structure
``` text
terraform/
ansible/
helm/
app/
.github/workflows/
```
Prerequisites
AWS Account
Terraform
Ansible
Docker
kubectl
Helm
Python 3
Development Deployment
``` bash
cd terraform
./scripts/init.sh dev
./scripts/apply.sh dev

cd ../ansible
ansible-playbook playbooks/site.yml
```
Production Deployment
``` bash
cd terraform
./scripts/init.sh prod
./scripts/apply.sh prod
```
Run the GitHub Actions workflow selecting prod.
CI/CD
Pipeline performs:
Checkout
Configure AWS credentials
Discover EC2
Generate inventory
SSH configuration
Update repository
Execute Ansible
Deploy application
Verify deployment
Monitoring
Prometheus collects cluster metrics
Grafana visualizes metrics
Metrics Server provides Kubernetes resource metrics
Useful commands:
``` bash
kubectl get pods -A
kubectl get svc -A
helm list -A
kubectl top nodes
kubectl top pods -A
```
Verification
``` bash
kind get clusters
kubectl get nodes
kubectl get pods -A
helm list -A
```
Screenshots
Add screenshots for:
Terraform Apply
GitHub Actions
Ansible
Kubernetes Pods
Helm Releases
Prometheus
Grafana
FastAPI Docs
Future Improvements
NGINX Ingress
TLS with cert-manager
ArgoCD
Custom Prometheus metrics
Grafana dashboards
Alertmanager rules
Author
Harsh Shrimali
GitHub: https://github.com/hs2002-18
