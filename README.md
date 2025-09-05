# Voting App (DevOps Demo)


![CI](https://github.com/BendibHafed/full_stack_desvops_simple_voting_app/actions/workflows/ci.yml/badge.svg)  
![License](https://img.shields.io/github/license/BendibHafed/full_stack_desvops_simple_voting_app)  
[![Docker Image](https://img.shields.io/badge/docker-ghcr.io%2FBendibHafed%2Ffull_stack_desvops_simple_voting_app-blue)](https://ghcr.io/BendibHafed/full_stack_desvops_simple_voting_app)


A simple full-stack **Voting Web Application** built with:
- **Frontend**: HTML, CSS, JavaScript (served by Flask in the same container for simplicity)
- **Backend**: Python Flask (with Gunicorn)
- **Database**: PostgreSQL

Deployed to **AWS (EC2 + RDS)** with **Terraform** (infrastructure) and **Ansible** (configuration management).  
CI/CD powered by **GitHub Actions**.

---

## Features
- Vote for predefined options
- View real-time vote counts
- API endpoints (/api/polls, /api/polls/<id>/vote, /healthz)
- Automated linting, tests, build and deployments

---

## Repository Structure
devops-voting-app/ </br>
├── app/ </br>
│ ├── frontend/ # HTML, CSS, JS </br>
│ └── backend/ # Flask app + tests </br>
├── infra/ </br>
│ ├── terraform/ # Infrastructure as Code (AWS) </br>
│ └── ansible/ # Configuration & deployment </br>
├── .github/workflows/ # CI/CD pipelines </br>
└── README.md </br>

---

## Tech Stack

- **Frontend**: Static files (HTML, CSS, JS) served by Flask (later: Separate Nginx container)
- **Backend**: Flask + Gunicorn
- **Database**: PostgreSQL (locally in Docker, RDS in AWS)
- **Infra**: AWS (Terraform)
- **Config Management**: Ansible
- **CI/CD**: GitHub Actions

---

## Quickstart (Local Development)
### Prerequisites

* Docker & Docker Compose installed
* Python 3.12 (only if running locally without Docker)

Run with Docker Compose
# From the project root
```bash
docker compose up -d --build
```
Frontend: http://localhost:5000

# Run Locally without Docker
```bash
# Install dependencies
cd backend
pip install -r requirements.txt

# Set environment variables
export FLASK_CONFIG=DevelopmentConfig
export DATABASE_URL=sqlite:///dev.db

# Initialize DB and seed data
python -m backend.seed

# Start app
python -m backend.run
```
---

## Testing

- **Unit tests**: Flask backend routes  
- **Integration tests**: Backend ↔ PostgreSQL
- **Smoke tests**: Health checks after deployment  

Run locally:
```bash
cd app/backend
pytest
```

---

## Deployment Workflow
- CI pipeline runs on PR:
- Python lint 
- Unit/integration tests (pytest) against PostgreSQL
- Terraform validate + lint
- Ansible lint
- Frontend lint (HTML/CSS/JS)
- Build Docker image
- Push image to GitHub Container Registry (GHCR)

---

## CD pipeline runs on main:
- terraform apply (EC2 + RDS)
- ansible-playbook (install Docker, deploy container)
- Run smoke tests (check API + homepage)

---

## Future Improvements
- Add authentication
- Containerize with Docker & Kubernetes
- Add monitoring (Prometheus + Grafana)
- Improve frontend with React

---

## Author
Built as a DevOps Engineering Demo Project — showing end-to-end CI/CD, Infrastructure as Code, and automated deployment.
