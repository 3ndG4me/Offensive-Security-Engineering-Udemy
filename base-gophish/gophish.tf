# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "kali" {
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["*Kali Linux*"]
  }

}


# Put your IP here to whitelist it for ssh

variable "access_addr" {
    type    = string
    default = "0.0.0.0/0"

}

resource "aws_security_group" "c2_group" {
  name        = "c2_group"
  description = "Allow Ports for GoPhish and SSH access"

  # Open common web ports for GoPhish
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  # ssh for remote access, might want to lock down to your IP prior to rolling out
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.access_addr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "primary_c2" {
  ami             = data.aws_ami.kali.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.c2_group.name]
  key_name        = "primary-c2-key"

  tags = {
    Name = "Primary Phish"
  }
}

output "IP" {
  value = aws_instance.primary_c2.public_ip
}
