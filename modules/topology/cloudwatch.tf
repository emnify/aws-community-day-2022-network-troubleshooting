resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = "Trouble-TGW"
  dashboard_body = templatefile(
    "${path.module}/dashboard.tpl", {
      tgw_id           = module.tgw.ec2_transit_gateway_id,
      tgw_attach_left  = module.tgw.ec2_transit_gateway_vpc_attachment_ids[0]
      tgw_attach_right = module.tgw.ec2_transit_gateway_vpc_attachment_ids[1]
      region           = data.aws_region.current.name
    }
  )
}