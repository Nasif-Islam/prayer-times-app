# Prayer Times App - DevOps Project

This is a simple **Flask application** that provides Islamic prayer times for a given city & country. The app is **Dockerized** and can be deployed to **AWS EC2 using Terraform**, demonstrating a complete DevOps workflow.

## Features
- Retrieve prayer times by city and country using the [AlAdhan API](http://aladhan.com).  
- Dockerized for consistent development and deployment.  
- Infrastructure as Code (IaC) using Terraform.  
- Automatically deployable on an EC2 instance with Docker.

## Project Structure
```text
prayer-times-project/
├── app/
│ ├── main.py           # Flask application
│ └── requirements.txt  # Python dependencies
├── Dockerfile          # Docker configuration
└── terraform/
  ├── main.tf             # Terraform resources (EC2, security group)
  ├── variables.tf        # Terraform variables
  └── outputs.tf          # Terraform outputs
```

## Quick start - run locally with
```bash
docker run -p 8000:5000 nasifislam/prayer-times-app
```

## Getting Started (Local Development)

### 1. Clone the repository
```bash
git clone <REPO_URL>
cd prayer-times-project
```

### 2. Run with Python (optional)
```bash
cd app
python main.py
```
- Open browser: http://localhost:5000/prayer-times/<city>/<country>
- Example: http://localhost:5000/prayer-times/London/UK

### 3. Run with Docker
```bash
docker build -t prayer-times-app .
docker run -p 8000:5000 prayer-times-app
```
- Open browser: http://localhost:8000/prayer-times/London/UK

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

### 3. Deploy with Terraform
```bash
cd terraform
terraform init
terraform apply
```
- Enter your AWS key pair name when prompted
- Terraform will create an EC2 instance, security group, and run your Docker container
- After completion, Terraform outputs app_public_ip

### 4. Access the App
```bash
http://<app_public_ip>/prayer-times/London/UK
```

## Technologies Used
- Python
- Flask
- Docker
- Terraform
- AWS EC2

### Notes for Reviewers
- The project demonstrates DevOps skills: Docker containerization, infrastructure as code, cloud deployment
- HTTPS is recommended for production, but HTTP is used here for simplicity
- Outbound traffic is open in the security group (protocol=-1) to allow Docker image pulls and updates

### Future Improvements
- Add automatic geolocation to detect user city
- Implement HTTPS with Nginx and Let’s Encrypt
- Add CI/CD pipeline for automatic deployment on Docker Hub push

### Contact
Built by https://github.com/Nasif-Islam