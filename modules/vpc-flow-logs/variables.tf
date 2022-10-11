variable "tags" {
  type        = map(string)
  description = "tags to apply to resources"
}

variable "flow_log_cloudwatch_log_group_retention_in_days" {
  type    = number
  default = 7
}