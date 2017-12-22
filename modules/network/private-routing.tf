resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "Private routing table"
  }
}

resource "aws_route" "nat" {
  route_table_id = "${aws_route_table.private.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.ngw.id}"
}

resource "aws_route_table_association" "private" {
  count = "${module.private_subnet.subnet_count}"

  route_table_id = "${aws_route_table.private.id}"
  subnet_id = "${element(module.private_subnet.subnet_ids, count.index)}"
}