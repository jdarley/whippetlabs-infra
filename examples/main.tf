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

data "template_file" "cloud_init" {
  template = "${file("./cloud_init.tpl")}"

  vars {
    firstname = "${var.firstname}"
  }
}

resource "aws_instance" "server" {
  ami = "${data.aws_ami.ec2-linux.id}"
  instance_type = "t2.small"
  subnet_id = "subnet-37d1387f"
  key_name = "training"
  associate_public_ip_address = true

  user_data = "${data.template_file.cloud_init.rendered}"

  vpc_security_group_ids = ["${aws_security_group.instance.id}"]

  tags {
    Name = "${var.firstname}' Server"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"
  vpc_id = "vpc-7345be15"

  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}