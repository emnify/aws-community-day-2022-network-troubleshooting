resource "aws_api_gateway_rest_api" "right" {
  name = "trouble"

  endpoint_configuration {
    types            = ["PRIVATE"]
    vpc_endpoint_ids = [aws_vpc_endpoint.api_gateway.id]
  }
}

resource "aws_vpc_endpoint" "api_gateway" {
  vpc_endpoint_type = "Interface"
  service_name      = "com.amazonaws.${data.aws_region.current.name}.execute-api"

  vpc_id             = module.vpc_right.vpc_id
  subnet_ids         = module.vpc_right.private_subnets
  security_group_ids = [aws_security_group.api_gateway.id]
}

resource "aws_security_group" "api_gateway" {
  vpc_id = module.vpc_right.vpc_id
  name   = "api-gateway"
}
