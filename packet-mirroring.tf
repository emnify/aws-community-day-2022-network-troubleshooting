module "packet_mirroring" {

  # If you want to destroy the client instance, mirroring will
  # complain, as it has its hand on the ENi.
  # So better deprovision the mirroring stack first by
  # uncommenting the following line

  # count = 0

  source = "./modules/packet-mirroring"

  mirrored_eni                    = module.topology.left_instance_eni
  left_vpc_cidr                   = module.topology.left_vpc_cidr
  left_vpc_private_route_table_id = module.topology.left_private_route_tables[0]
  transit_gateway_id              = module.topology.transit_gateway_id
  transit_gateway_route_table_id  = module.topology.transit_gateway_route_table_id
}