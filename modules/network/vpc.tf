resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc-cidr-block}"
  enable_dns_hostnames = true
  tags = {
    Name = "WhippetLabs VPC"
  }
}

module "public_subnet" {
  source = "../subnet"

  vpc-id = "${aws_vpc.vpc.id}"
  cidr-blocks = "${var.public-cidr-blocks}"
  subnet-name = "public"
  assign_public_ip = true
}

module "private_subnet" {
  source = "../subnet"

  vpc-id = "${aws_vpc.vpc.id}"
  cidr-blocks = "${var.private-cidr-blocks}"
  subnet-name = "private"
}
