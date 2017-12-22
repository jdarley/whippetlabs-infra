resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "ngw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${module.public_subnet.subnet_ids[0]}"
}