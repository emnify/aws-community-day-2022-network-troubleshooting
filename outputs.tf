output "topology_client_instance_id" {
  description = "Instance ID of the client instance"
  value       = module.topology.left_instance_id
}

output "topology_right_apigw_dns_entry" {
  description = "Host name of the API Gateway that the client wants to reach"
  value       = module.topology.right_apigw_dns_entry
}

output "metrics_dashboard_url" {
  description = "URL of the TGW metrics dashboard"
  value       = try(module.metrics.dashboard_url, null)
}

output "packet_capture_receiver_instance_id" {
  description = "Instance ID of the packet capture receiver instance"
  value       = try(module.packet_mirroring.instance_id, null)
}