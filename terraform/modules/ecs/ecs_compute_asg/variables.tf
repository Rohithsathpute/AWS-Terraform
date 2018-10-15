variable "env_name" {}
variable "vpc_id" {}

variable "iam_instance_profile" {}

variable "asg_name" {}
variable "asg_max_size" { default = "1" }
variable "asg_min_size" { default = "1" }
variable "asg_desired_capacity" { default = "1"}

variable "subnets" {type = "list"}
variable "security_groups" { type = "list" }
variable "associate_public_ip_address" { default = false}

variable "instance_type" {}
variable "key_name" {}
variable "root_block_device_size" { default = "20" }
variable "root_block_device_type" { default = "gp2" }

variable "user_data" {
  default = ""
}