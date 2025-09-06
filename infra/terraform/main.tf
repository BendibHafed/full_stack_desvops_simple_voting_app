# Key pair for SSH/Ansible
resource "aws_key_pair" "voting_key" {
  key_name   = "voting-key"
  public_key = var.ssh_public_key
}

# Security Group
resource "aws_security_group" "voting_sg" {
  name        = "voting-app-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "voting_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.voting_key.key_name
  vpc_security_group_ids = [aws_security_group.voting_sg.id]
  subnet_id = data.aws_subnets.default.ids[0]

  tags = {
    Name = "VotingAppEC2"
  }
  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install -y python3 python3-pip
  EOF
}

resource "aws_db_instance" "voting_db" {
  identifier = "voting-db"
  engine = "postgres"
  instance_class = var.db_instance_class
  allocated_storage = 8
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
  skip_final_snapshot = true
  publicly_accessible = true
  vpc_security_group_ids = [aws_security_group.voting_sg.id]
  monitoring_interval = 60
  tags = {
    Name = "VotingAppDB"
  }
}