# Candidate Test – DevOps Assignment

This project provisions an **Azure VM** and deploys **Keycloak**, **Postgres**, and **Nginx** using **Terraform**, **Ansible**, **Docker Compose**, and **GitHub Actions**.

---

## Features
- **Infrastructure as Code (Terraform)** – creates VM, networking, and security rules in Azure  
- **Configuration Management (Ansible)** – installs Docker and deploys containers  
- **Authentication (Keycloak + Postgres)** – Keycloak for identity, Postgres as its DB  
- **Web Server (Nginx)** – serves a static webpage  
- **CI/CD (GitHub Actions)** – workflows for deploy and destroy  #Do note that due to timelimit on this task and my current work. i didn't had the time to finish the Github Actions setup, so I wrote a template that can be used as a starting point.
- **Documentation** – architecture diagram, justification, and future improvements  

---

## Repository Structure
.
├── .github/workflows/ # GitHub Actions CI/CD

│ ├── deploy.yml

│ └── destroy.yml

├── terraform/ # Terraform configs (VM + networking)

├── ansible/ # Ansible playbooks & roles

│ ├── inventory.ini

│ ├── playbook.yml

│ └── roles/docker-host/

│ ├── tasks/main.yml

│ └── files/nginx/site/index.html

├── diagrams/ # Architecture diagram

└── README.md # Project documentation


---

## How to Deploy

### 1. Trigger Deploy
- Go to **GitHub → Actions → Deploy Infrastructure → Run workflow**  
- This runs:
  - `terraform apply` → provisions Azure VM + networking  
  - `ansible-playbook` → installs Docker, deploys Keycloak + Postgres + Nginx  

### 2. Access Services
- **Web Page (Nginx):**  
  `http://<VM_PUBLIC_IP>/`  

- **Keycloak Admin:**  
  `http://<VM_PUBLIC_IP>:8080/auth`  
  - Username: `admin`  
  - Password: `admin123`  

### 3. Trigger Destroy
- Go to **GitHub → Actions → Destroy Infrastructure → Run workflow**  
- This runs `terraform destroy` and tears down all resources.  

---

## Architecture

### Justification
- A **single Azure VM (free tier)** is used for cost efficiency  
- **Terraform** provides reproducible infra setup  
- **Ansible** handles configuration and container deployments  
- **Docker Compose** groups the services into isolated containers  
- **GitHub Actions** enables CI/CD automation for consistency  
- **Networking (NSG)** restricts inbound traffic:  
  - SSH (22) for admins  
  - HTTP (80) for Nginx  
  - HTTP (8080) for Keycloak  

---

##  Suggested Future Features
- **TLS/HTTPS with Let’s Encrypt** → secure authentication  
- **Move Postgres to Azure Managed DB** → backups, reliability  
- **Use Kubernetes (AKS)** → scalability and resilience  
- **Add Monitoring (Prometheus + Grafana)** → observability  
- **CI/CD tests before deploy** → safer deployments  

## Notes on Issues Encountered and Resolutions
1. OAuth2 Proxy Connection Refused
Issue:
Initially, the OAuth2 Proxy container was not accessible externally, resulting in connection refused errors when trying to connect to port 4180.

Resolution:
Added the environment variable OAUTH2_PROXY_HTTP_ADDRESS: "0.0.0.0:4180" to make OAuth2 Proxy listen on all network interfaces rather than the default localhost. This fixed the connectivity issue allowing external access to OAuth2 Proxy.

2. Keycloak HTTPS Requirement Error
Issue:
Keycloak was enforcing HTTPS for authentication but the environment was only accessible over HTTP, leading to "HTTPS required" errors on login.

Resolution:
Temporarily disabled HTTPS requirement for the Keycloak realm by setting sslRequired=NONE using the Keycloak admin CLI (kcadm.sh). For production, enabling proper HTTPS with certificates is recommended.

3. Incorrect Nginx Configuration
Issue:
Nginx was not correctly proxying the auth requests to OAuth2 Proxy, causing authentication failures.

Resolution:
Created a custom Nginx config (default.conf) with proper auth_request and proxy_pass directives to forward auth requests to OAuth2 Proxy. This configuration was deployed via Ansible and mounted as a volume in the Nginx container.
