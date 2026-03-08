provider "aws" {
  region = "ap-south-1"
}

variable "key_name" {
  default = "devops-key"
}

resource "aws_security_group" "web_sg" {
  name = "cicd-security-group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# DEV SERVER
resource "aws_instance" "dev" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name      = var.key_name

  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "Dev-Server"
  }
}

# STAGING SERVER
resource "aws_instance" "staging" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name      = var.key_name

  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "Staging-Server"
  }
}

# PRODUCTION SERVER
resource "aws_instance" "prod" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name      = var.key_name

  security_groups = [aws_security_group.web_sg.name]

  tags = {
    Name = "Production-Server"
  }
}

output "dev_ip" {
  value = aws_instance.dev.public_ip
}

output "staging_ip" {
  value = aws_instance.staging.public_ip
}

output "prod_ip" {
  value = aws_instance.prod.public_ip
}