# Voting App (DevOps Demo)

A simple full-stack **Voting Web Application** built with:
- **Frontend**: HTML, CSS, JavaScript (served via Nginx)
- **Backend**: Python Flask (Gunicorn + Systemd)
- **Database**: PostgreSQL

Deployed to **AWS (EC2 + RDS)** with **Terraform** (infrastructure) and **Ansible** (configuration management).  
CI/CD powered by **GitHub Actions**.

---

## Features
- Vote for predefined options
- View real-time vote counts
- API endpoints (`/options`, `/vote`, `/healthz`)
- Automated tests & deployments

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

- **Frontend**: Nginx serving static files
- **Backend**: Flask + Gunicorn
- **Database**: PostgreSQL (RDS)
- **Infra**: AWS (Terraform)
- **Config Management**: Ansible
- **CI/CD**: GitHub Actions

---

## Testing

- **Unit tests**: Flask backend routes  
- **Integration tests**: Backend ↔ DB  
- **Smoke tests**: Health checks after deployment  

Run locally:
```bash
cd app/backend
pytest
```

---

## Deployment Workflow
- CI pipeline runs on PR:
- Python lint + unit tests
- Terraform validate + lint
- Ansible lint
- Frontend lint (HTML/CSS/JS)
---

## CD pipeline runs on main:
- terraform apply (EC2 + RDS)
- ansible-playbook (install Nginx, deploy frontend/backend)
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
