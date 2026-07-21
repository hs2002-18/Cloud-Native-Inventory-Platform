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

## 🛠️ Tech Stack

**Backend:**

[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)

[![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com/)

[![Pydantic](https://img.shields.io/badge/Pydantic-E92063?style=for-the-badge&logo=pydantic&logoColor=white)](https://pydantic-docs.helpmanual.io/)

[![Uvicorn](https://img.shields.io/badge/Uvicorn-FFC107?style=for-the-badge&logo=uvicorn&logoColor=black)](https://www.uvicorn.org/)

**Database:**

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)

**Cloud & DevOps:**

[![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)

[![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)

[![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)](https://www.ansible.com/)

[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)

[![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io/)

[![Helm](https://img.shields.io/badge/Helm-0F1689?style=for-the-badge&logo=helm&logoColor=white)](https://helm.sh/)

[![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)](https://github.com/features/actions)

[![Prometheus](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)](https://prometheus.io/)

[![Grafana](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)](https://grafana.com/)
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
