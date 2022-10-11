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
    Name = "Gimme everything"
  }
}

resource "aws_ec2_traffic_mirror_target" "this" {
  description          = ""
  network_interface_id = module.receiver_instance.primary_network_interface_id

  tags = {
    Name = local.name
  }
}
# unfortunately, Terraform AWS provider is buggy when
# omitting the protocol (it sets protocol to 0, but should
# be just left out from the request. Therefor, loop over
# all interesting protocols

locals {
  protocols = { icmp = 1, tcp = 6, udp = 17 }
}
resource "aws_ec2_traffic_mirror_filter_rule" "out" {
  traffic_mirror_filter_id = aws_ec2_traffic_mirror_filter.this.id

  for_each = local.protocols

  # who has designed this API?
  rule_number = 1 + index(values(local.protocols), each.value)

  description       = ""
  traffic_direction = "egress"

  source_cidr_block      = "0.0.0.0/0"
  destination_cidr_block = "0.0.0.0/0"

  protocol = each.value
  #  destination_port_range {
  #    from_port = 443
  #    to_port = 443
  # }
  rule_action = "accept"
}
resource "aws_ec2_traffic_mirror_filter_rule" "in" {
  traffic_mirror_filter_id = aws_ec2_traffic_mirror_filter.this.id

  for_each = local.protocols

  # who has designed this API?
  rule_number = 1 + index(values(local.protocols), each.value)

  description       = ""
  traffic_direction = "ingress"

  source_cidr_block      = "0.0.0.0/0"
  destination_cidr_block = "0.0.0.0/0"

  protocol = each.value
  #  source_port_range {
  #    from_port = 443
  #    to_port = 443
  #  }
  rule_action = "accept"
}
