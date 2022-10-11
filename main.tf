module "topology" {
  source = "./modules/topology"

  vpc_flow_logs_iam_arn          = module.flow_logs.iam_role_arn
  vpc_flow_logs_log_group_prefix = module.flow_logs.cloudwatch_log_group_prefix
  vpc_flow_logs_log_group_arn    = module.flow_logs.cloudwatch_log_group_arn
}

module "flow_logs" {
  source = "./modules/vpc-flow-logs"

  tags = {}
}

output "instance-left" {
  value = module.topology.left_instance_id
}