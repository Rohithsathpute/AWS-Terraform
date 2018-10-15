// Module specific variables
variable "security_group_name" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}


variable "source_cidr_blocks" {
  type = "list"
  default = []
  description = "The source CIDR block to allow traffic from"
}

variable "source_security_groups" {
  default = []
  type = "list"
}

variable "tags" {
  default = {
    Terraform         = "true"
  }
  type = "map"
}
