# RDS endpoint
output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.voting_db.address
}

# RDS port
output "rds_port" {
  description = "RDS PostgreSQL port"
  value       = aws_db_instance.voting_db.port
}

output "app_url" {
  value = "http://${aws_lb.voting_alb.dns_name}"
}
