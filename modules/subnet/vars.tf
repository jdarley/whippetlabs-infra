variable "vpc-id" {
  description = "The id of the VPC to create the subnet(s) in"
}

variable "cidr-blocks" {
  description = "A comma separated list of CIDR blocks to assign to the subnets to be created"
}

variable "subnet-name" {
  description = "The name to use to identify the subnets being created"
}

variable "assign_public_ip" {
  default = false
}
