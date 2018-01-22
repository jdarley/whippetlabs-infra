output "public_ip" {
  value = "${aws_instance.server.public_ip}"
}
/*

output "cloud_init" {
  value = "${data.template_file.cloud_init.rendered}"
}*/
