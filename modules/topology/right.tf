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

module "vpc_right" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "right"
  cidr = "10.2.0.0/16"

  azs             = ["${data.aws_region.current.name}a"]
  private_subnets = ["10.2.0.0/24"]

  enable_dns_hostnames = true
}

###################################################
###################################################
#######
#######         _    ____ ___    ______        __
#######        / \  |  _ \_ _|  / ___\ \      / /
#######       / _ \ | |_) | |  | |  _ \ \ /\ / /
#######      / ___ \|  __/| |  | |_| | \ V  V /
#######     /_/   \_\_|  |___|  \____|  \_/\_/
#######
###################################################
###################################################

resource "aws_api_gateway_rest_api" "right" {
  name = "trouble"

  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = [aws_vpc_endpoint.api_gateway.id]
  }
}

resource "aws_vpc_endpoint" "api_gateway" {
  vpc_endpoint_type = "Interface"
  service_name      = "com.amazonaws.${data.aws_region.current.name}.execute-api"

  vpc_id             = module.vpc_right.vpc_id
  subnet_ids         = module.vpc_right.private_subnets
  security_group_ids = [aws_security_group.api_gateway.id]

  tags = {
    Name = "Private API GW"
  }
}

resource "aws_security_group" "api_gateway" {
  vpc_id = module.vpc_right.vpc_id
  name   = "api-gateway"

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
}
