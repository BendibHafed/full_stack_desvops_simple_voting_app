# 🗳️ Voting App (DevOps Demo)

A simple full-stack **Voting Web Application** built with:
- **Frontend**: HTML, CSS, JavaScript (served via Nginx)
- **Backend**: Python Flask (Gunicorn + Systemd)
- **Database**: PostgreSQL

Deployed to **AWS (EC2 + RDS)** with **Terraform** (infrastructure) and **Ansible** (configuration management).  
CI/CD powered by **GitHub Actions**.

---

## 🚀 Features
- Vote for predefined options
- View real-time vote counts
- API endpoints (`/options`, `/vote`, `/healthz`)
- Automated tests & deployments

---

## 📂 Repository Structure
devops-voting-app/
├── app/
│ ├── frontend/ # HTML, CSS, JS
│ └── backend/ # Flask app + tests
├── infra/
│ ├── terraform/ # Infrastructure as Code (AWS)
│ └── ansible/ # Configuration & deployment
├── .github/workflows/ # CI/CD pipelines
└── README.md
