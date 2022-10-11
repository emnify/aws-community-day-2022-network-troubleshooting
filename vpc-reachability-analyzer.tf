module "vpc_reachability_analyzer" {
  source = "./modules/vpc-reachability-analyzer"

  left_instance_id     = module.topology.left_instance_id
  right_apigw_vpce_eni = module.topology.right_apigw_vpce_eni
}