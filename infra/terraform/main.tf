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
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
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
  subnet_id              = data.aws_subnets.default.ids[0]

  tags = {
    Name = "VotingAppEC2"
  }
}

resource "aws_db_instance" "voting_db" {
  identifier             = "voting-db"
  engine                 = "postgres"
  instance_class         = var.db_instance_class
  allocated_storage      = 8
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.voting_sg.id]
  monitoring_interval    = 60
  monitoring_role_arn    = aws_iam_role.rds_monitoring_role.arn
  tags = {
    Name = "VotingAppDB"
  }
}

resource "aws_iam_role" "rds_monitoring_role" {
  name = "rds-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "monitoring.rds.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  role       = aws_iam_role.rds_monitoring_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_security_group" "alb_sg" {
  name = "voting-app-alb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "Allow HTTP"
    from_port = 5000
    to_port = 5000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "voting_alb" {
  name               = "voting-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_target_group" "app_tg" {
  name     = "voting-app-tg"
  port     = 5000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/healthz"
    port                = 5000
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.voting_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "app_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.voting_ec2.id
  port             = 5000
}