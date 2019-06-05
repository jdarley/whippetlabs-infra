output "vpc-id" {
  value = module.network.vpc-id
}

output "private-subnet-ids" {
  value = module.network.private-subnet-ids
}

output "public-subnet-ids" {
  value = module.network.public-subnet-ids
}

//
//output "elb-dns-name" {
//  value = "${aws_elb.elb.dns_name}"
//}
