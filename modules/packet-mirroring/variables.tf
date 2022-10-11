variable "mirrored_eni" {
  description = "ENI to be mirrored"
  type        = string
}

variable "left_vpc_cidr" {
  type = string
}

variable "transit_gateway_id" {
  type = string
}

variable "transit_gateway_route_table_id" {
  type = string
}

variable "left_vpc_private_route_table_id" {
  description = "Route table of the left VPC, as we need to tweak its routing table so that mirrored packets are sent to TGW :-/"
  type        = string
}

