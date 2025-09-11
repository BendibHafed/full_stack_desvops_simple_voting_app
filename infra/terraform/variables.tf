variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "eu-west-3"
}

variable "aws_profile" {
  description = "AWS CLI profile name (for local dev)"
  type        = string
  default     = "default"
}

variable "aws_access_key" {
  description = "AWS Access Key for CI/CD"
  type        = string
  sensitive   = true
  default = ""
}

variable "aws_secret_key" {
  description = "AWS Secret Key for CI/CD"
  type        = string
  sensitive   = true
  default = ""
}

variable "ssh_public_key" {
  description = "SSH public key for EC2 access"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for backend/frontend container"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "appuser"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
  default= ""
}