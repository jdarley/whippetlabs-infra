resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "Public routing table"
  }
}

resource "aws_route" "igw" {
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.igw.id}"
}

resource "aws_route_table_association" "public" {
  count = "${module.public_subnet.subnet_count}"

  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${element(module.public_subnet.subnet_ids, count.index)}"
}
