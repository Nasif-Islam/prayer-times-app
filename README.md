# 🕌 Prayer Times App – Full-Stack DevOps Project
![React](https://img.shields.io/badge/React-61DAFB?logo=react&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=black)
![Nginx](https://img.shields.io/badge/Nginx-009639?logo=nginx&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-000000?logo=flask&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-7B42BC?logo=terraform&logoColor=white)
![AWS EC2](https://img.shields.io/badge/AWS%20EC2-FF9900?logo=amazonaws&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?logo=git&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-181717?logo=github&logoColor=white)
![AlAdhan API](https://img.shields.io/badge/AlAdhan-API-blueviolet)

A simple full-stack web application that displays **Islamic prayer times** by city and country using the [AlAdhan API](https://aladhan.com/prayer-times-api)  
Built with **Flask (Python)** for the backend, **React (JavaScript)** for the frontend, and deployed using **Docker** and **Terraform** on **AWS EC2**

---

## Features

- Retrieve accurate daily prayer times via the AlAdhan API  
- Flask backend serving RESTful endpoints  
- React frontend for displaying prayer times dynamically  
- Dockerized backend and frontend for consistent deployment
- Infrastructure as Code (IaC) with Terraform to deploy on AWS  
- Configurable security group, key pair, and Docker image pull via Terraform  
- Custom bridge network connecting frontend and backend containers

## Architecture Diagram

## Project Structure

```text
prayer-times-app/
├── backend/
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
├── backend.Dockerfile
├── frontend.Dockerfile
├── docker-compose.yml
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
python -m venv .venv
source .venv/bin/activate # for macOS/Linux     or      .venv\Scripts\activate for Windows
pip install -r requirements.txt
python main.py
```
Then open your browser at: http://localhost:8000/prayer-times/<city>/<country>  
Example: http://localhost:8000/prayer-times/London/UK

### 3. Frontend Setup (React)

```bash
cd frontend
npm install
npm start
```
Runs at: http://localhost:3000  
React frontend fetches prayer times from the Flask backend API.

### 4. Run Locally With Docker

```bash
docker-compose up --build
```
Open frontend at http://localhost:3000. 
Open backend at http://localhost:8000/prayer-times/London/UK

## Deploying to AWS using Terraform

### Requirements
- AWS account & CLI configured
- SHSH key pair for EC2 access
- Docker Hub Account for hosting the image 

### 1. Configure AWS CLI

```bash
aws configure
```
Enter your Access Key, Secret Key, default region (eu-west-1 recommended) & output format (json)

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
Enter your AWS key pair name when prompted  
Terraform will:
- Create an EC2 instance
- Create a security group
- Install Docker
- Pull and run your image
After completion, Terraform will output the public IP:
- http://<EC2_PUBLIC_IP>/prayer-times/London/UK

### 4. Access the App

```bash
http://<app_public_ip>/prayer-times/London/UK
```

## Notes for Reviewers
- The project demonstrates DevOps skills: coding, Docker containerization, Infrastructure as Code, cloud deployment
- Uses Docker networking to connect frontend & backend
- HTTPS is recommended for production, but HTTP is used here for simplicity
- Outbound traffic is open in the security group (protocol=-1) to allow Docker image pulls and updates
- Terraform setup can easily scale to ECS or EKS

## Future Improvements
- Add automatic geolocation for user-based prayer times
- Enable HTTPS with Nginx and Let’s Encrypt
- Add CI/CD pipeline for automatic AWS deployment with GitHub Actions
- Mobile-friendly responsive UI
- Deploy on AWS ECS or Fargate

## Author
GitHub:     https://github.com/Nasif-Islam
LinkedIn:   https://www.linkedin.com/in/nasiful-i-106287336/