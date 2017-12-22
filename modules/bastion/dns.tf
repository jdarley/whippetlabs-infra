resource "aws_route53_record" "bastion" {
  zone_id = "${var.dns-zone-id}"
  name = "bastion"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.bastion-eip.public_ip}"]
}