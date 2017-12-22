variable "vpc-cidr-block" {
  description = "The CIDR block for the entire VPC"
}

variable "public-cidr-blocks" {
  description = "A common separated list of CIDR blocks to use for public subnets"
}

variable "private-cidr-blocks" {
  description = "A common separated list of CIDR blocks to use for private subnets"
}

variable "ci-cidr-blocks" {
  description = "A common separated list of CIDR blocks to use for the ci subnets"
}
