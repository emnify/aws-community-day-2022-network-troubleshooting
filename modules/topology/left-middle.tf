###################################################
###################################################
#######
#######     __     ______   ____   ____                _
#######     \ \   / /  _ \ / ___| |  _ \ ___  ___ _ __(_)_ __   __ _
#######      \ \ / /| |_) | |     | |_) / _ \/ _ \ '__| | '_ \ / _` |
#######       \ V / |  __/| |___  |  __/  __/  __/ |  | | | | | (_| |
#######        \_/  |_|    \____| |_|   \___|\___|_|  |_|_| |_|\__, |
#######
###################################################
###################################################

resource "aws_vpc_peering_connection" "left_middle" {
  vpc_id      = module.vpc_left.vpc_id
  peer_vpc_id = module.vpc_middle.vpc_id

  auto_accept = true
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