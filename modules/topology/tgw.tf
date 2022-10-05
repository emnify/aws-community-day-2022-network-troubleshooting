###################################################
###################################################
#######
#######      _____ ______        __
#######     |_   _/ ___\ \      / /
#######       | || |  _ \ \ /\ / /
#######       | || |_| | \ V  V /
#######       |_| \____|  \_/\_/
#######
###################################################
###################################################

module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "2.8.0"

  name        = "trouble-tgw"
  description = "Troublesome Transit Gateway"

  vpc_attachments = {
    left = {
      vpc_id      = module.vpc_left.vpc_id
      subnet_ids  = module.vpc_left.private_subnets
      dns_support = true

      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false

    },
    right = {
      vpc_id      = module.vpc_right.vpc_id
      subnet_ids  = module.vpc_right.private_subnets
      dns_support = true

      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false
    },
  }
}

resource "aws_route" "left_to_right" {
  route_table_id         = one(module.vpc_left.private_route_table_ids)
  destination_cidr_block = module.vpc_right.vpc_cidr_block
  transit_gateway_id     = module.tgw.ec2_transit_gateway_id
}

resource "aws_route" "right_to_left" {
  route_table_id         = one(module.vpc_right.private_route_table_ids)
  destination_cidr_block = module.vpc_left.vpc_cidr_block
  transit_gateway_id     = module.tgw.ec2_transit_gateway_id
}