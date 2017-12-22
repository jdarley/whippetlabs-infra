output "ci-subnet-ids" {
  value = "${module.ci_subnet.subnet_ids}"
}

output "ci-to-db-access-id" {
  value = "${aws_security_group.ci-network-access-to-db-group.id}"
}
