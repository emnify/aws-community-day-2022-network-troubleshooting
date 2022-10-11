resource "aws_cloudwatch_dashboard" "this" {
  dashboard_name = "Trouble-TGW"
  dashboard_body = templatefile(
    "${path.module}/dashboard.tpl", {
      region           = data.aws_region.current.name
      tgw_id           = var.tgw_id
      tgw_attach_left  = var.tgw_attachments[0]
      tgw_attach_right = var.tgw_attachments[1]
    }
  )
}
