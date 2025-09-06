# Public IP of the EC2 instance
output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.voting_app.public_ip
}

# Application URL
output "app_url" {
  description = "URL to access the Voting App"
  value       = "http://${aws_instance.voting_app.public_ip}"
}

# Public DNS of the EC2 instance
output "ec2_public_dns" {
  description = "Public DNS of EC2"
  value       = aws_instance.voting_app.public_dns
}
