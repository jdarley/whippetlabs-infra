data "aws_availability_zones" "vpc_zone" {}

resource "aws_vpn_gateway" "whippetlabs_gateway" {
  vpc_id = module.network.vpc-id
  availability_zone = data.aws_availability_zones.vpc_zone.names[0]
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = module.network.vpc-id
  vpn_gateway_id = aws_vpn_gateway.whippetlabs_gateway.id
}

resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = var.vpn-wan-ip
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = aws_vpn_gateway.whippetlabs_gateway.id
  customer_gateway_id = aws_customer_gateway.customer_gateway.id
  type                = "ipsec.1"
  static_routes_only  = true
  tunnel1_preshared_key = var.vpn-preshared-key-1
  tunnel2_preshared_key = var.vpn-preshared-key-2
}

resource "aws_vpn_connection_route" "office" {
  destination_cidr_block = var.vpn-cidr-block
  vpn_connection_id = aws_vpn_connection.main.id
}
