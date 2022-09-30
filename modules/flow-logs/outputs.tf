output "iam_role_arn" {
  value = aws_iam_role.vpc_flow_log_cloudwatch.arn
}

output "cloudwatch_log_group_prefix" {
  value = aws_cloudwatch_log_group.flow_log.name_prefix
}

output "cloudwatch_log_group_arn" {
  value = aws_cloudwatch_log_group.flow_log.arn
}

