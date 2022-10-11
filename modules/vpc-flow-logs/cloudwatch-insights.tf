resource "aws_cloudwatch_query_definition" "all_parsed" {
  name            = "vpc-flow-logs-all-parsed"
  query_string    = <<EOF
parse @message "* * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
| as account_id, action, az_id, bytes, dst_addr, dst_port, end, flow_direction,
| instance_id, interface_id, logstatus, packets, pkt_dst_aws_service, pkt_dstaddr, pkt_src_aws_service, pkt_srcaddr,
| protocol, region, src_addr, src_port, start, sublocation_id, sublocation_type, subnet_id,
| tcp_flags, traffic_path, type, version, vpc_id
| sort start desc
EOF
  log_group_names = [aws_cloudwatch_log_group.flow_log.name]
}

resource "aws_cloudwatch_query_definition" "port_80" {
  name            = "vpc-flow-logs-port-80"
  query_string    = <<EOF
parse @message "* * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
| as account_id, action, az_id, bytes, dst_addr, dst_port, end, flow_direction,
| instance_id, interface_id, logstatus, packets, pkt_dst_aws_service, pkt_dstaddr, pkt_src_aws_service, pkt_srcaddr,
| protocol, region, src_addr, src_port, start, sublocation_id, sublocation_type, subnet_id,
| tcp_flags, traffic_path, type, version, vpc_id
| sort start desc
| filter src_port = 80 or dst_port = 80
EOF
  log_group_names = [aws_cloudwatch_log_group.flow_log.name]
}