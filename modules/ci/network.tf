locals {
  ci_cidr_block_list = "${split(",", var.ci-cidr-blocks)}"
  ci_subnet_count = "${length(local.ci_cidr_block_list)}"
}

module "ci_subnet" {
  source = "../subnet"

  vpc-id = "${var.vpc-id}"
  cidr-blocks = "${var.ci-cidr-blocks}"
  subnet-name = "CI"
}

resource "aws_route_table" "ci" {
  vpc_id = "${var.vpc-id}"
  tags {
    Name = "CI subnet"
  }
}

resource "aws_route" "ci-nat" {
  route_table_id = "${aws_route_table.ci.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${var.nat-gw-id}"
}

resource "aws_route" "ci-vpn" {
  route_table_id = "${aws_route_table.ci.id}"
  destination_cidr_block = "10.0.0.0/9"
  gateway_id = "${var.vpn-gw-id}"
}

resource "aws_route_table_association" "ci" {
  count = "${local.ci_subnet_count}"

  subnet_id = "${element(module.ci_subnet.subnet_ids, count.index)}"
  route_table_id = "${aws_route_table.ci.id}"
}

