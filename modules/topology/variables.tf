variable "vpc_flow_logs_iam_arn" {

}

variable "vpc_flow_logs_log_group_prefix" {

}

variable "vpc_flow_logs_log_group_arn" {

}

variable "vpc_flog_logs_format" {
  type = string
  default = "$${version} $${account-id} $${interface-id} $${srcaddr} $${dstaddr} $${srcport} $${dstport} $${protocol} $${packets} $${bytes} $${start} $${end} $${action} $${log-status} $${vpc-id} $${subnet-id} $${instance-id} $${tcp-flags} $${type} $${pkt-srcaddr} $${pkt-dstaddr} $${region} $${az-id} $${sublocation-type} $${sublocation-id} $${pkt-src-aws-service} $${pkt-dst-aws-service} $${flow-direction} $${traffic-path}"
}