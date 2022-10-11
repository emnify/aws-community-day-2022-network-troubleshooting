module "packet_mirroring" {

  #  count = 0

  source = "./modules/packet-mirroring"

  mirrored_eni                   = module.topology.left_instance_eni
  transit_gateway_id             = module.topology.transit_gateway_id
  transit_gateway_route_table_id = module.topology.transit_gateway_route_table_id
}