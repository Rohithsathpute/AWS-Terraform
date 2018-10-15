data "aws_ami" "ecs_ami" {
  most_recent      = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

    filter {
    name = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized*"]
    }
}

resource "aws_launch_configuration" "mod" {
  image_id                    = "${data.aws_ami.ecs_ami.id}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${var.key_name}"
  root_block_device {
    volume_size = "${var.root_block_device_size}"
    volume_type = "${var.root_block_device_type}"
  }
  security_groups             = [
    "${aws_security_group.hosts.id}",
    "${aws_security_group.hosts-int.id}",
    "${var.security_groups}",
  ]
  iam_instance_profile        = "${var.iam_instance_profile}"
  associate_public_ip_address = "${var.associate_public_ip_address}"

  lifecycle {
    create_before_destroy = true
  }

  user_data = "${var.user_data}"
}
