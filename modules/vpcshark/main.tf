resource "aws_launch_template" "this" {
  name = "vpcshark"

  image_id = "ami-0ea0f26a6d50850c5"

  instance_type = "t3.small"

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.public_subnet_id
    security_groups             = [aws_security_group.this.id]
  }


  # iam_instance_profile {  }
  tags = {
    Name = "vpcshark"
  }
}

resource "aws_security_group" "this" {
  name = "vpcshark"

  vpc_id = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "udp"
    from_port   = 4789
    to_port     = 4789
    cidr_blocks = ["0.0.0.0/0"]
  }
}


data "aws_ami" "amazon_linux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-arm64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}
