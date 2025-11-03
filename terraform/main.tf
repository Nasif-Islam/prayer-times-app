# Specify the AWS provider and region
provider "aws" {
  region = "eu-west-1"  # Ireland region
}

# Security group to allow HTTP traffic (port 80)
resource "aws_security_group" "allow_http" {
  name        = "allow_http"
  description = "Allow HTTP inbound traffic"

  # Inbound rule - allow HTTP traffic on port 80 from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]     # Allow from all IPs
  }

  # Outbound rule - allow all traffic out
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"              # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance to host the Docker container
resource "aws_instance" "app_server" {
  ami           = "ami-062f7200baf2fa504"  # Amazon Linux 2 AMI in eu-west-1
  instance_type = "t2.micro"
  key_name      = var.key_name              # AWS key pair for SSH
  security_groups = [aws_security_group.allow_http.name]

  # User data runs on startup
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -a -G docker ec2-user
              docker pull <YOUR_DOCKERHUB_USERNAME>/prayer-times-app:latest
              docker run -d -p 80:5000 <YOUR_DOCKERHUB_USERNAME>/prayer-times-app:latest
              EOF

  tags = {
    Name = "PrayerTimesApp"
  }
}

# Output the public IP of the ec2 instance after deployment
output "public_ip" {
  value = aws_instance.app_server.public_ip
}
