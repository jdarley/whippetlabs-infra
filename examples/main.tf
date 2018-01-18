data "aws_ami" "ec2-linux" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "owner-alias"
    values = ["amazon"]
  }
}

resource "aws_instance" "server" {
  ami = "${data.aws_ami.ec2-linux.id}"
  instance_type = "t2.small"
  subnet_id = "subnet-e75db0af"
  key_name = "training"
  associate_public_ip_address = true

  tags {
    Name = "James' Server"
  }
}

output "ami-details" {
  value = "${data.aws_ami.ec2-linux.id}"
}