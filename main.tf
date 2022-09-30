module "topology" {
  source = "./modules/topology"

  vpc_flow_logs_iam_arn          = module.flow_logs.iam_role_arn
  vpc_flow_logs_log_group_prefix = module.flow_logs.cloudwatch_log_group_prefix
  vpc_flow_logs_log_group_arn    = module.flow_logs.cloudwatch_log_group_arn
}

module "flow_logs" {
  source = "./modules/flow-logs"

  tags = {}
}

output "instance-left" {
  value = module.topology.left_instance_id
}

resource "aws_ec2_network_insights_path" "demo" {
  source      = module.topology.left_instance_id
  destination = module.topology.right_apigw_vpce_eni
  protocol    = "tcp"
}