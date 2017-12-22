variable "vpc-id" {
  description = "The ID of the VPC to attach to"
}

variable "nat-gw-id" {
  description = "The ID of the NAT gateway to attach"
}

variable "ci-cidr-blocks" {
  description = "A common separated list of CIDR blocks to use for CI subnets"
}
