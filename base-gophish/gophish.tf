# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

# Subscribe to latest Kali instance in market place first! https://aws.amazon.com/marketplace/pp/prodview-fznsw3f7mq7to
data "aws_ami" "kali" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["kali-last-snapshot-amd64-2024.4.1-804fcc46-63fc-4eb6-85a1-50e66d6c7215"]
  }

}


# Put your IP here to whitelist it for ssh

variable "access_addr" {
    type    = string
    default = "0.0.0.0/0"

}

resource "aws_security_group" "phish_group" {
  name        = "phish_group"
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

resource "aws_instance" "primary_phish" {
  ami             = data.aws_ami.kali.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.phish_group.name]
  key_name        = "primary-c2-key"

  tags = {
    Name = "Primary Phish"
  }
}

output "IP" {
  value = aws_instance.primary_phish.public_ip
}
