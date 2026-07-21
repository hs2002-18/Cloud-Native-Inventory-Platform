# ☁️ Cloud Native Inventory Platform

Cloud Native Inventory Platform is an end-to-end DevOps project that demonstrates infrastructure provisioning, configuration management, Kubernetes deployment, monitoring, and CI/CD automation on AWS.

The project provisions infrastructure using Terraform, configures the server using Ansible, deploys a FastAPI application on a Kubernetes (Kind) cluster using Helm, and integrates Prometheus and Grafana for monitoring. GitHub Actions automates deployments for both development and production environments.

---

# ✨ Features

- Multi-environment infrastructure (Development & Production)
- Infrastructure provisioning using Terraform
- EC2 provisioning on AWS
- Automated server configuration using Ansible
- Dockerized FastAPI application
- Kubernetes deployment using Kind
- Helm-based application deployment
- Prometheus monitoring
- Grafana dashboards
- GitHub Actions CI/CD pipeline
- Automated inventory generation for Ansible

---

# 🛠️ Tech Stack

**Cloud**

- AWS EC2
- IAM

**Infrastructure as Code**

- Terraform

**Configuration Management**

- Ansible

**Containers & Orchestration**

- Docker
- Kubernetes (Kind)
- Helm

**Application**

- Python
- FastAPI

**Monitoring**

- Prometheus
- Grafana

**CI/CD**

- GitHub Actions

---

# 📁 Project Structure

```text
Cloud-Native-Inventory-Platform/
│
├── .github/
│   └── workflows/
│       └── deploy.yml
│
├── ansible/
│   ├── inventory/
│   │   └── hosts.ini
│   ├── playbooks/
│   │   ├── group_vars/
│   │   │   └── all.yml
│   │   └── site.yml
│   ├── roles/
│   │   ├── common/
│   │   ├── docker/
│   │   ├── helm/
│   │   ├── inventory-platform/
│   │   ├── kind/
│   │   └── kubectl/
│   └── scripts/
│       └── generate_inventory.sh
│
├── app/
│   ├── models/
│   ├── routers/
│   ├── schemas/
│   ├── services/
│   ├── __init__.py
│   ├── config.py
│   ├── database.py
│   ├── logger.py
│   ├── main.py
│   └── requirements.txt
│
├── helm/
│   └── inventory-platform/
│       ├── templates/
│       ├── Chart.yaml
│       └── values.yaml
│
├── terraform/
│   ├── bootstrap/
│   ├── environments/
│   │   ├── dev/
│   │   └── prod/
│   ├── modules/
│   │   ├── ec2/
│   │   ├── networking/
│   │   └── security/
│   └── scripts/
│       ├── apply.sh
│       ├── init.sh
│       ├── plan.sh
│       └── validate.sh
│
├── .dockerignore
├── .gitignore
├── Dockerfile
├── LICENSE
└── README.md
```

---

# 🏗️ Architecture

```text
                    Terraform
                        │
                        ▼
                  AWS Infrastructure
                        │
                        ▼
                   EC2 Instance
                        ▲
                        │
          SSH + Ansible │
                        │
Developer ───▶ GitHub ─▶ GitHub Actions
                        │
                        ▼
                    git pull
                        │
                        ▼
                     Docker
                        │
                        ▼
                  Kind Cluster
                        │
                        ▼
                   Kubernetes
                        │
                        ▼
               Inventory Platform
                        │
                 ┌──────┴──────┐
                 ▼             ▼
           Prometheus      Grafana
```

---

# ⚙️ Prerequisites

- AWS Account
- Terraform
- Ansible
- Docker
- kubectl
- Helm
- GitHub Account
- Python 3

---

# 🚀 Deploy Infrastructure

Initialize Terraform

```bash
cd terraform

./scripts/init.sh dev
```

Validate

```bash
./scripts/validate.sh
```

Plan

```bash
./scripts/plan.sh dev
```

Apply

```bash
./scripts/apply.sh dev
```

---

# 🤖 Configure Server

Generate inventory

```bash
./ansible/scripts/generate_inventory.sh dev
```

Run Ansible

```bash
ansible-playbook ansible/playbooks/site.yml
```

---

# ☸️ Kubernetes Deployment

The Ansible playbook automatically:

- Installs Docker
- Installs kubectl
- Installs Kind
- Creates Kubernetes cluster
- Installs Helm
- Builds Docker image
- Loads image into Kind
- Deploys application
- Installs Metrics Server
- Installs Prometheus
- Installs Grafana

---

# 📊 Monitoring

The monitoring stack includes:

- Prometheus
- Grafana
- Metrics Server

Useful commands:

```bash
kubectl get pods -A

kubectl get svc -A

helm list -A
```

---

# 🔄 CI/CD Pipeline

GitHub Actions performs the following:

- Checkout repository
- Configure AWS credentials
- Generate Ansible inventory
- Connect to EC2
- Pull latest repository
- Execute Ansible playbook
- Deploy latest application
- Verify deployment

Supports both:

- Development
- Production

---

# 🚧 Future Improvements

- NGINX Ingress
- TLS using cert-manager
- ArgoCD
- Custom Prometheus metrics
- Grafana dashboards
- Alerting rules

---

# 📄 License

This project is licensed under the MIT License.

---

# 👨‍💻 Author

**Harsh Shrimali**

GitHub: https://github.com/hs2002-18

---

## ⭐ If you found this project useful, consider giving it a star!
