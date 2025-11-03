# Purpose: After deployment, Terraform shows the public IP so you can visit your app
output "app_public_ip" {
  description = "Public IP of your EC2 instance"
  value       = aws_instance.app_server.public_ip
}