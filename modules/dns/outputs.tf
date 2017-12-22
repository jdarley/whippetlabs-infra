output "zone-id" {
  value = "${aws_route53_zone.public.id}"
}

output "name-servers" {
  value = "${aws_route53_zone.public.name_servers}"
}