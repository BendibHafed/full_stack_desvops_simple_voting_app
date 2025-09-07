# Public IP of the EC2 instance
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.voting_ec2.public_ip
}

# RDS endpoint
output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.voting_db.endpoint
}

# RDS port
output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.voting_db.port
}

# Application URL
output "app_url" {
  description = "URL to access the Voting App"
  value       = "http://${aws_instance.voting_ec2.public_ip}"
}

# Public DNS of the EC2 instance
output "ec2_public_dns" {
  description = "Public DNS of EC2"
  value       = aws_instance.voting_ec2.public_dns
}
