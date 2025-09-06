# Key pair for SSH/Ansible
resource "aws_key_pair" "voting_key" {
  key_name   = "voting-app-key"
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
  egress {
    description = "Outbound to All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "voting_app" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.micro"
  key_name        = aws_key_pair.voting_key.key_name
  security_groups = [aws_security_group.voting_sg.name]

  tags = {
    Name = "VotingAppInstance"
  }
}