locals {
  name = "capture-receiver"
}

###################################################
###################################################
#######
#######     __     ______   ____
#######     \ \   / /  _ \ / ___|
#######      \ \ / /| |_) | |
#######       \ V / |  __/| |___
#######        \_/  |_|    \____|
#######
###################################################
###################################################

module "vpc_receiver" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = local.name
  cidr = "10.99.0.0/16"

  azs             = ["eu-west-1a"]
  private_subnets = ["10.99.0.0/24"]
  public_subnets  = ["10.99.1.0/24"]

  enable_dns_hostnames = true
  enable_nat_gateway   = true
}

resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  vpc_id             = module.vpc_receiver.vpc_id
  subnet_ids         = module.vpc_receiver.private_subnets
  transit_gateway_id = var.transit_gateway_id

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}

resource "aws_ec2_transit_gateway_route_table_association" "this" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "this" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}

###################################################
###################################################
#######
#######      ___           _
#######     |_ _|_ __  ___| |_ __ _ _ __   ___ ___
#######      | || '_ \/ __| __/ _` | '_ \ / __/ _ \
#######      | || | | \__ \ || (_| | | | | (_|  __/
#######     |___|_| |_|___/\__\__,_|_| |_|\___\___|
#######
###################################################
###################################################

module "receiver_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"

  name      = local.name
  subnet_id = one(module.vpc_receiver.private_subnets)

  ami                    = data.aws_ami.ubuntu_2004_arm.id
  instance_type          = "t4g.micro"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.receiver_instance.id]

  iam_instance_profile = aws_iam_instance_profile.receiver_instance.name
  user_data            = "apt-get update; apt-get install -y tcpdump"
}

resource "aws_security_group" "receiver_instance" {
  name   = local.name
  vpc_id = module.vpc_receiver.vpc_id

  ingress {
    protocol    = "udp"
    from_port   = 4789
    to_port     = 4789
    cidr_blocks = [module.vpc_receiver.vpc_cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "ubuntu_2004_arm" {
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

resource "aws_iam_instance_profile" "receiver_instance" {
  name = local.name
  role = aws_iam_role.receiver_instance.name
}

resource "aws_iam_role" "receiver_instance" {
  name = local.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "receiver_instance" {
  role       = aws_iam_role.receiver_instance.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}