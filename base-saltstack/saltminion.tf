data "aws_ami" "ubuntu_minion" {
  most_recent = "true"
  owners      = ["aws-marketplace"]
  count = 2

  filter {
    name   = "name"
    values = ["f991a988-22fb-4c72-a790-09e227224ea5.3b73ef49-208f-47e1-8a6e-4ae768d8a333.DC0001"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_security_group" "ssh_group" {
  name        = "ssh_group"
  description = "Allow Ports for SSH access"

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

resource "aws_instance" "secondary_salt" {

  count = length(data.aws_ami.ubuntu_minion)

  ami             = data.aws_ami.ubuntu_minion[count.index].id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ssh_group.name]
  key_name        = "primary-c2-key"


  tags = {
    Name = "Secondary salt"
  }
}


output "Minion_One" {
  value = aws_instance.secondary_salt[0].public_ip
}

output "Minion_Two" {
  value = aws_instance.secondary_salt[1].public_ip
}
