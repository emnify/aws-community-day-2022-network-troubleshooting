resource "aws_ec2_traffic_mirror_session" "this" {
  network_interface_id     = var.mirrored_eni
  session_number           = 1
  traffic_mirror_filter_id = aws_ec2_traffic_mirror_filter.this.id
  traffic_mirror_target_id = aws_ec2_traffic_mirror_target.this.id

  tags = {
    Name = "Capture Trouble"
  }
}

resource "aws_ec2_traffic_mirror_filter" "this" {
  description      = ""
  network_services = ["amazon-dns"]

  tags = {
    Name = "HTTP and HTTPS"
  }
}

resource "aws_ec2_traffic_mirror_target" "this" {
  description          = ""
  network_interface_id = module.receiver_instance.primary_network_interface_id
  #  network_load_balancer_arn = ""
  #  gateway_load_balancer_endpoint_id = ""

  tags = {
    Name = local.name
  }
}

resource "aws_ec2_traffic_mirror_filter_rule" "out" {
  traffic_mirror_filter_id = aws_ec2_traffic_mirror_filter.this.id

  description            = ""
  traffic_direction      = "egress"
  rule_number            = 1
  source_cidr_block      = "0.0.0.0/0"
  destination_cidr_block = "0.0.0.0/0"
  protocol               = 6
  #  destination_port_range {
  #    from_port = 443
  #    to_port = 443
  # }
  rule_action = "accept"
}
resource "aws_ec2_traffic_mirror_filter_rule" "in_443" {
  traffic_mirror_filter_id = aws_ec2_traffic_mirror_filter.this.id

  description       = ""
  traffic_direction = "ingress"
  rule_number       = 1

  source_cidr_block      = "0.0.0.0/0"
  destination_cidr_block = "0.0.0.0/0"
  protocol               = 6
  #  source_port_range {
  #    from_port = 443
  #    to_port = 443
  #  }
  rule_action = "accept"
}
