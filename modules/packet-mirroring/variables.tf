variable "mirrored_eni" {
  description = "ENI to be mirrored"
  type        = string
}

variable "transit_gateway_id" {
  type = string
}

variable "transit_gateway_route_table_id" {
  type = string
}