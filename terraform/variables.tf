variable "region" { default = "us-east-1"}

variable "project_name" {}
variable "environment_name" {}

variable "cidr" { default = "10.20.0.0/16" }
variable "private_subnets" { type = "list" default = ["10.20.50.0/24", "10.20.51.0/24", "10.20.52.0/24"] }
variable "public_subnets" { type = "list" default = ["10.20.150.0/24", "10.20.151.0/24", "10.20.152.0/24"] }
variable "database_subnets" { type = "list" default = ["10.20.200.0/24", "10.20.201.0/24", "10.20.202.0/24"] }

variable "ecs_instance_type" { default = "t2.micro" }

variable "ecs_asg_max_size" { default = "1" }
variable "ecs_asg_min_size" { default = "1" }
variable "ecs_asg_desired_capacity" { default = "1" }

variable "ecs_task_desired_count" { default = "1" }
variable "ecs_task_memory" { default = "512"}

variable "docker_build_image" { default = 0}
