variable "firstname" {
  description = "Your first name"
  default     = "James"
}

module "network" {
  source = "../modules/network"

  vpc-cidr-block = "10.12.152.0/23"

  public-cidr-blocks  = "10.12.152.0/24"
  private-cidr-blocks = "10.12.153.0/24"
}

data "aws_ami" "ec2-linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

data "template_file" "cloud_init" {
  template = file("./cloud_init.tpl")

  vars = {
    firstname = var.firstname
  }
}

resource "aws_launch_configuration" "launch-config" {
  name          = "server-launch-config"
  image_id      =  data.aws_ami.ec2-linux.id
  instance_type = "t2.micro"
  user_data     = data.template_file.cloud_init.rendered

  security_groups = [aws_security_group.instance.id]
}

resource "aws_autoscaling_group" "server-scaling-group" {
  name = "server-auto-scaling-group"
  vpc_zone_identifier       = [module.network.private-subnet-ids[0]]
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "EC2"
  launch_configuration      = aws_launch_configuration.launch-config.name
  load_balancers            = [aws_elb.elb.name]

  tag {
    key                 = "Name"
    value               = "${var.firstname}’s Server"
    propagate_at_launch = true
  }
}

resource "aws_elb" "elb" {
  name = "elb"
  subnets         = module.network.public-subnet-ids
  security_groups = [aws_security_group.elb.id]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    interval            = 5
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
    target              = "HTTP:8080/"
  }
}

resource "aws_security_group" "elb" {
  name        = "elb-security-group"
  vpc_id      = module.network.vpc-id
  description = "Internet facing ELB security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["10.12.153.0/24"]
  }
}

resource "aws_security_group" "instance" {
  name        = "instance-security-group"
  vpc_id      = module.network.vpc-id
  description = "ELB to instance security group"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.elb.id]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

