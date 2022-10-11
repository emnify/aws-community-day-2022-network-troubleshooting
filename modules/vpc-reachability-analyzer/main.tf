resource "aws_ec2_network_insights_path" "vpce" {
  tags = {
    Name = "Trouble client to API GW"
  }

  source           = var.left_instance_id
  destination      = var.right_apigw_vpce_eni
  protocol         = "tcp"
  destination_port = 80
}
