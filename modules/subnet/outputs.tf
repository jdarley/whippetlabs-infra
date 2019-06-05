output "subnet_count" {
  value = "${length(split(",", var.cidr-blocks))}"
}

output "subnet_ids" {
  value = "${aws_subnet.subnet.*.id}"
}

output "subnet_cidr_blocks" {
  value = "${aws_subnet.subnet.*.cidr_block}"
}
