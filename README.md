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
