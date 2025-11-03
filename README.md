# 🕌 Prayer Times App – Full-Stack DevOps Project

A simple full-stack web application that displays **Islamic prayer times** by city and country using the [AlAdhan API](https://aladhan.com/prayer-times-api)  
Built with **Flask (Python)** for the backend, **React (JavaScript)** for the frontend, and deployed on **AWS EC2** using **Docker** and **Terraform**

---

## Features

- Retrieve accurate daily prayer times via the AlAdhan API  
- Flask backend serving RESTful endpoints  
- React frontend for displaying prayer times dynamically  
- Dockerized backend for consistent environments  
- Infrastructure as Code (IaC) with Terraform to deploy on AWS  
- Configurable security group, key pair, and Docker image pull via Terraform  

## Project Structure

```text
prayer-times-app/
├── backend/
│   ├── .venv/
│   ├── main.py
│   └── requirements.txt
├── frontend/
│   ├── package.json
│   ├── package-lock.json
│   ├── public/
│   │   ├── index.html
│   │   └── favicon.ico
│   └── src/
│       ├── App.js
│       ├── App.css
│       ├── index.js
│       └── index.css
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   └── variables.tf
├── Dockerfile
└── README.md
```

## Getting Started

### 1. Clone the repository

```bash
git clone <REPO_URL>
cd prayer-times-app
```

### 2. Backend Setup (Flask)

```bash
cd backend
# Set up and activate virtual environment
python -m venv .venv
source .venv/bin/activate     # macOS/Linux
# .venv\Scripts\activate      # Windows
pip install -r requirements.txt
python main.py
```
- Then open browser at: http://localhost:5000/prayer-times/<city>/<country>
- Example: http://localhost:5000/prayer-times/London/UK

## 3. Frontend Setup (React)

```bash
cd frontend
npm install
npm start
```
- Runs at: http://localhost:3000
- React frontend fetches prayer times from the Flask backend API.

### 3. Run with Docker

```bash
docker build -t prayer-times-app .
docker run -p 8000:5000 prayer-times-app
```
- Then open browser at: http://localhost:8000/prayer-times/London/UK

## Deployment to AWS using Terraform - Requires an AWS account and key pair

### 1. Configure AWS CLI

```bash
aws configure
```
- Enter your Access Key, Secret Key, default region (eu-west-1 recommended), and output format (json)

### 2. Build & Push Docker Image to Docker Hub

```bash
docker build -t <YOUR_DOCKERHUB_USERNAME>/prayer-times-app:latest .
docker push <YOUR_DOCKERHUB_USERNAME>/prayer-times-app:latest
```

### 3. Deploy infrastructure with Terraform

```bash
cd terraform
terraform init
terraform apply
```
- Enter your AWS key pair name when prompted
- Terraform creates an EC2 instance, security group, and run your Docker container
- After completion, Terraform outputs app_public_ip

### 4. Access the App

```bash
http://<app_public_ip>/prayer-time-app/London/UK
```

## Technologies Used
- Frontend: React, JavaScript
- Backend: Flask, Python
- API: AlAdhan Prayer Times API
- Containerization: Docker
- Infrastructure: Terraform, AWS EC2
- Version Control: Git, GitHub

### Notes for Reviewers
- The project demonstrates DevOps skills: Docker containerization, infrastructure as code, cloud deployment
- HTTPS is recommended for production, but HTTP is used here for simplicity
- Outbound traffic is open in the security group (protocol=-1) to allow Docker image pulls and updates

### Future Improvements
- Add automatic geolocation for user-based prayer times
- Enable HTTPS with Nginx and Let’s Encrypt
- Add CI/CD pipeline for automatic AWS deployment
- Mobile-friendly responsive UI

### Contact
Built by https://github.com/Nasif-Islam