output "vpc-id" {
  value = "${aws_vpc.vpc.id}"
}

output "public-route-table-id" {
  value = "${aws_route_table.public.id}"
}

output "private-route-table-id" {
  value = "${aws_route_table.private.id}"
}

output "private-subnet-ids" {
  value = "${module.private_subnet.subnet_ids}"
}

output "public-subnet-ids" {
  value = "${module.public_subnet.subnet_ids}"
}