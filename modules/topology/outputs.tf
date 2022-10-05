output "left_instance_id" {
  description = "Instance ID in the left VPC"
  value       = module.instance_left.id
}

output "left_instance_eni" {
  description = "ENI ID in of the client instance"
  value       = module.instance_left.primary_network_interface_id
}

output "right_apigw_vpce_eni" {
  description = "ENI ID of the VPC endpoint of the private API Gateway in the right VPC"
  value       = one(aws_vpc_endpoint.api_gateway.network_interface_ids)
}

output "right_apigw_dns_entry" {
  value = aws_vpc_endpoint.api_gateway.dns_entry[0]["dns_name"]
}

output "transit_gateway_id" {
  value = module.tgw.ec2_transit_gateway_id
}

output "transit_gateway_route_table_id" {
  value = module.tgw.ec2_transit_gateway_route_table_id
}