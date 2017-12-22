variable "dns-zone-id" {}

variable "vpc-id" {}

variable "subnet-ids" {
  description = "Subnet to launch EC2 instances in"
  type = "list"
}