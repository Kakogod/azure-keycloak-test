# Azure Keycloak Candidate Test

This project provisions an Azure VM with Terraform, configures it with Ansible, and deploys Keycloak + Postgres + Nginx in Docker containers.

## Structure
- `terraform/` – Infrastructure as Code for Azure
- `ansible/` – Configuration management and container deployment
- `docker/` – Local docker-compose for development
- `.github/workflows/` – CI/CD automation with GitHub Actions
- `docs/` – Architecture diagram and documentation

## Steps to Run
1. Provision Azure infrastructure (`terraform apply`)
2. Configure VM (`ansible-playbook`)
3. Access Keycloak-protected static site in browser

