output "instance_id" {
  value = module.receiver_instance.id
}

output "vpc_id" {
  value = module.vpc_receiver.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc_receiver.public_subnets
}