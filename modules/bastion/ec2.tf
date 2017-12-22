resource aws_eip "bastion-eip" {}

resource "aws_launch_configuration" "bastion" {
  name          = "bastion"
  image_id      = "ami-acd005d5"
  instance_type = "t2.micro"

  key_name = "bastion"

  security_groups = ["${aws_security_group.bastion.id}"]

  associate_public_ip_address = true
}


resource "aws_autoscaling_group" "bastion-scaling-group" {
  vpc_zone_identifier       = ["${var.subnet-ids}"]
  name                      = "bastion-autoscalling-group"

  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = false
  launch_configuration      = "${aws_launch_configuration.bastion.name}"

  tag {
    key                 = "Name"
    value               = "bastion"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "bastion" {
  name        = "bastion"
  vpc_id      = "${var.vpc-id}"
  description = "Bastion security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bastion"
  }
}