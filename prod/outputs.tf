output "vpc-id" {
  value = "${module.network.vpc-id}"
}

output "private-subnet-ids" {
  value = "${module.network.private-subnet-ids}"
}

output "public-subnet-ids" {
  value = "${module.network.public-subnet-ids}"
}

output "dns-name-servers" {
  value = "${module.dns.name-servers}"
}

output "dns-zone-id" {
  value = "${module.dns.zone-id}"
}