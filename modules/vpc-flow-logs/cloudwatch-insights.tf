resource "aws_cloudwatch_query_definition" "all_parsed" {
  name            = "vpc-flow-logs-all-parsed"
  query_string    = <<EOF
parse @message "* * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
| as version, account_id, interface_id, src_addr, dst_addr, src_port, dst_port, protocol, packets, bytes, start, end, action, logstatus,
| vpc_id, subnet_id, instance_id, tcp_flags, type, pkt_srcaddr, pkt_dstaddr,
| region, az_id, sublocation_type, sublocation_id,
| pkt_src_aws_service, pkt_dst_aws_service, flow_direction, traffic_path
| sort start desc
EOF
  log_group_names = [aws_cloudwatch_log_group.flow_log.name]
}

resource "aws_cloudwatch_query_definition" "port_80" {
  name            = "vpc-flow-logs-port-80"
  query_string    = <<EOF
parse @message "* * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
| as version, account_id, interface_id, src_addr, dst_addr, src_port, dst_port, protocol, packets, bytes, start, end, action, logstatus,
| vpc_id, subnet_id, instance_id, tcp_flags, type, pkt_srcaddr, pkt_dstaddr,
| region, az_id, sublocation_type, sublocation_id,
| pkt_src_aws_service, pkt_dst_aws_service, flow_direction, traffic_path
| sort start desc
| filter src_port = 80 or dst_port = 80
EOF
  log_group_names = [aws_cloudwatch_log_group.flow_log.name]
}