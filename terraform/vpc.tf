# These types of resources are created:
# - Amazon Virtual Private Cloud
# - Amazon Public and Private Subnets
# - Amazon Route Tables
# - Amazon Internet Gateway

module "vpc" {
  source               = "./modules/tf_aws_vpc"
  name                 = "${var.environment_name}-${var.project_name}-vpc"
  cidr                 = "${var.cidr}"
  private_subnets      = "${var.private_subnets}"
  public_subnets       = "${var.public_subnets}"
  database_subnets     = "${var.database_subnets}"
  enable_nat_gateway   = "false"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  azs = [
    "${data.aws_availability_zones.available.names[0]}",
    "${data.aws_availability_zones.available.names[1]}",
    "${data.aws_availability_zones.available.names[2]}",
  ]

  tags {
    "Terraform"   = "true"
    "ProjectName" = "${var.project_name}"
    "Environment" = "${var.environment_name}"
  }
}
