resource "aws_autoscaling_group" "mod" {
  name                      = "${var.asg_name}-${aws_launch_configuration.mod.name}"
  launch_configuration      = "${aws_launch_configuration.mod.name}"
  health_check_grace_period = 500
  health_check_type         = "EC2"
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  desired_capacity          = "${var.asg_desired_capacity}"
  vpc_zone_identifier       = ["${var.subnets}"]

  tag {
    key                 = "Name"
    value               = "${var.asg_name}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
