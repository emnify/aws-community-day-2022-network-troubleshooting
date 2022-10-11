resource "aws_route" "vpc_left_to_vpc_capture" {

  route_table_id = var.left_vpc_private_route_table_id

  destination_cidr_block = module.vpc_receiver.vpc_cidr_block
  transit_gateway_id     = var.transit_gateway_id
}