# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "ubuntu" {
  most_recent = "true"

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}


# Put your IP here to whitelist it for ssh

variable "access_addr" {
    type    = string
    default = "0.0.0.0/0"

}

resource "aws_security_group" "vpn_group" {
  name        = "vpn_group"
  description = "Allow Ports for VPN and SSH access"

  # Open the default OpenVPN Port
  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "udp"
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

resource "aws_instance" "primary_vpn" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.vpn_group.name]
  key_name        = "primary-c2-key"


  tags = {
    Name = "Primary vpn"
  }
}

output "IP" {
  value = aws_instance.primary_vpn.public_ip
}
