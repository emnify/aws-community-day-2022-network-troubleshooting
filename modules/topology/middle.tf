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

module "vpc_middle" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "middle"
  cidr = "10.2.0.0/16"

  azs             = ["${data.aws_region.current.name}a"]
  private_subnets = ["10.2.0.0/24"]

  enable_dns_hostnames = true
}

resource "aws_lb" "nlb" {
  name               = "trouble"
  internal           = true
  load_balancer_type = "network"
  subnets            = [for subnet in module.vpc_middle.private_subnets : subnet]

  enable_deletion_protection = true

  tags = {
    Name = "trouble"
  }
}

resource "aws_security_group" "nlb" {

}

resource "aws_vpc_endpoint_service" "middle" {
  acceptance_required = false
  network_load_balancer_arns = [aws_lb.nlb.arn]
}

resource "aws_lb_target_group" "port80" {
  name = "port80"
  port = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = module.vpc_middle.vpc_id
}

resource "aws_lb_target_group_attachment" "port80" {
  target_group_arn = aws_lb_target_group.port80.arn
  // hardcode for now
  target_id        = "10.3.0.212"
  availability_zone = "all"
}