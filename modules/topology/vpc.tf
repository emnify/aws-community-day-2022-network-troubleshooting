module "vpc_left" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "left"
  cidr = "10.1.0.0/16"

  azs             = ["eu-west-1a"]
  private_subnets = ["10.1.0.0/24"]

  enable_dns_hostnames = true
}

module "vpc_middle" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "middle"
  cidr = "10.2.0.0/16"

  azs             = ["eu-west-1a"]
  private_subnets = ["10.2.0.0/24"]

  enable_dns_hostnames = true
}

module "vpc_right" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.4"

  name = "right"
  cidr = "10.3.0.0/16"

  azs             = ["eu-west-1a"]
  private_subnets = ["10.3.0.0/24"]

  enable_dns_hostnames = true
}