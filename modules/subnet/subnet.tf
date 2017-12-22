data "aws_availability_zones" "available" {}

locals {
  cidr_block_list = "${split(",", var.cidr-blocks)}"
  subnet_count = "${length(local.cidr_block_list)}"
}

resource "aws_subnet" "subnet" {
  count = "${local.subnet_count}"

  vpc_id = "${var.vpc-id}"
  cidr_block = "${element(local.cidr_block_list, count.index)}"
  availability_zone = "${element(data.aws_availability_zones.available.names, count.index)}"
  tags {
    Name = "${var.subnet-name} (${element(data.aws_availability_zones.available.names, count.index)})"
  }
}