data "aws_ami" "ubuntu_minion" {
  most_recent = "true"

  count = 2

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
