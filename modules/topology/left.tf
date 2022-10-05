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

module "vpc_left" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "left"
  cidr = "10.1.0.0/16"

  azs             = ["${data.aws_region.current.name}a"]
  private_subnets = ["10.1.0.0/24"]

  enable_dns_hostnames = true
}

resource "aws_vpc_endpoint" "left" {
  for_each = toset(["ssm", "ssmmessages", "ec2messages"])

  vpc_endpoint_type = "Interface"
  service_name      = "com.amazonaws.${data.aws_region.current.name}.${each.value}"

  private_dns_enabled = true

  vpc_id             = module.vpc_left.vpc_id
  subnet_ids         = module.vpc_left.private_subnets
  security_group_ids = [aws_security_group.vpces_left.id]
}

resource "aws_security_group" "vpces_left" {
  name   = "trouble-vpce"
  vpc_id = module.vpc_left.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = [module.vpc_left.vpc_cidr_block]
  }
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

module "instance_left" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"

  name      = "client"
  subnet_id = one(module.vpc_left.private_subnets)

  ami                    = data.aws_ami.ubuntu_2004_arm.id
  instance_type          = "t4g.micro"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.instance_left.id]

  iam_instance_profile = aws_iam_instance_profile.instance_left.name
  user_data            = data.template_cloudinit_config.config.rendered
}

data "template_file" "left-instance-user-data" {
  template = file("${path.module}/left-instance-user-data.yml.tpl")

  vars = {
    curl_destination = "example.com"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.left-instance-user-data.rendered
    merge_type   = "dict(recurse_list,no_replace)+list(append)"
  }
}

resource "aws_security_group" "instance_left" {
  name   = "instance-left"
  vpc_id = module.vpc_left.vpc_id

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

resource "aws_iam_instance_profile" "instance_left" {
  name = "instance-left"
  role = aws_iam_role.instance_left.name
}

resource "aws_iam_role" "instance_left" {
  name = "instance-left"

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

resource "aws_iam_role_policy_attachment" "instance_left" {
  role       = aws_iam_role.instance_left.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}