resource "aws_security_group" "ci-network-access-to-db-group" {
  name = "ci-subnets-to-db-access"
  tags {
    Name = "ci-subnets-to-db-access"
  }
  description = "Accesss from CI subnet to database subnets"
  vpc_id      = "${var.vpc-id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = "${split(",", var.ci-cidr-blocks)}"
  }
}