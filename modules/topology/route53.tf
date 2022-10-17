resource "aws_route53_zone" "main" {
  name = "demo.org"

  vpc {
    vpc_id = module.vpc_left.vpc_id
  }
}

resource "aws_route53_zone_association" "left" {
  vpc_id  = module.vpc_left.vpc_id
  zone_id = aws_route53_zone.main.id
}

resource "aws_route53_zone_association" "right" {
  vpc_id  = module.vpc_right.vpc_id
  zone_id = aws_route53_zone.main.id
}

data "aws_network_interface" "vpce_api" {
  id = tolist(aws_vpc_endpoint.api_gateway.network_interface_ids)[0]
}

resource "aws_route53_record" "api" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api.demo.org"
  type    = "A"
  ttl     = "30"
  records = [data.aws_network_interface.vpce_api.private_ip]
}

resource "aws_route53_record" "api2" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "api2.demo.org"
  type    = "CNAME"
  ttl     = "30"
  records = ["${aws_api_gateway_rest_api.right.id}.execute-api.eu-central-1.amazonaws.com"]
}

