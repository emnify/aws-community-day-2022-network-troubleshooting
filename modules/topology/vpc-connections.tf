resource "aws_vpc_peering_connection" "left_middle" {
  vpc_id      = module.vpc_left.vpc_id
  peer_vpc_id = module.vpc_middle.vpc_id
}

resource "aws_route" "left_to_vpc_peering" {
  for_each = toset([module.vpc_middle.vpc_cidr_block, module.vpc_right.vpc_cidr_block])

  route_table_id            = module.vpc_left.private_route_table_ids[0]
  destination_cidr_block    = each.value
  vpc_peering_connection_id = aws_vpc_peering_connection.left_middle.id
}

resource "aws_route" "middle_to_vpc_peering" {
  route_table_id            = module.vpc_middle.private_route_table_ids[0]
  destination_cidr_block    = module.vpc_left.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.left_middle.id
}

module "tgw_middle_right" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "2.8.0"

  name        = "middle-right"
  description = "Troublesome Transit Gateway"

  vpc_attachments = {
    middle = {
      vpc_id      = module.vpc_middle.vpc_id
      subnet_ids  = module.vpc_middle.private_subnets
      dns_support = true

      tgw_routes = [
        {
          destination_cidr_block = module.vpc_middle.vpc_cidr_block
        },
        {
          destination_cidr_block = module.vpc_left.vpc_cidr_block
        },
      ]
    },
    right = {
      vpc_id      = module.vpc_right.vpc_id
      subnet_ids  = module.vpc_right.private_subnets
      dns_support = true

      tgw_routes = [
        {
          destination_cidr_block = module.vpc_right.vpc_cidr_block
        },
      ]
    },
  }
}