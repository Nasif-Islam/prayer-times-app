# Purpose: Prompts you for the AWS key name when running terraform apply
variable "key_name" {
  description = "Name of your AWS key pair"
  type        = string
}