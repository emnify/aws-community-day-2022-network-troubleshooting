module "metrics" {

  source = "./modules/metrics"

  tgw_id          = module.topology.transit_gateway_id
  tgw_attachments = module.topology.transit_gateway_vcp_attachment_ids
}