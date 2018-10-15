# These types of resources are created:
# - Amazon ECS Cluster
# - Auto Scaling Group
# - Launch Configuration
# - Amazon Security Groups

resource "aws_ecs_cluster" "worker-ecs" {
  name = "${var.project_name}-${var.environment_name}"
}

module "worker-ecs-asg" {
  source = "./modules/ecs/ecs_compute_asg"

  env_name = "${var.environment_name}"
  vpc_id   = "${module.vpc.vpc_id}"

  iam_instance_profile = "${aws_iam_instance_profile.profile.name}"

  subnets = "${module.vpc.public_subnets}"

  security_groups = [
    "${module.ssh-sg.security_group_id}",
  ]

  instance_type = "${var.ecs_instance_type}"
  key_name      = "${aws_key_pair.prod-key.key_name}"

  asg_name             = "${var.project_name}-${var.environment_name}-worker"
  asg_max_size         = "${var.ecs_asg_max_size}"
  asg_min_size         = "${var.ecs_asg_min_size}"
  asg_desired_capacity = "${var.ecs_asg_desired_capacity}"

  user_data = <<USER_DATA
Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
echo 'ECS_CLUSTER=${aws_ecs_cluster.worker-ecs.name}' >> /etc/ecs/ecs.config
region=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
sed -i -e "s/region = us-east-1/region = $region/g" /etc/awslogs/awscli.conf

--==BOUNDARY==--
USER_DATA
}

module "ssh-sg" {
  source              = "./modules/tf_aws_sg_ssh"
  security_group_name = "tf-${var.project_name}-${var.environment_name}-ssh-sg"
  vpc_id              = "${module.vpc.vpc_id}"
  source_cidr_blocks  = ["0.0.0.0/0"]
}
