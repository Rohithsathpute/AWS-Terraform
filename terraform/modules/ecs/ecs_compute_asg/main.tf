resource "aws_security_group" "hosts" {
  name        = "${var.env_name}-ecs-hosts-sg"
  vpc_id      = "${var.vpc_id}"
  description = "ECS hosts SG"

  ingress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    security_groups = [
      "${var.security_groups}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.env_name}-ecs-hosts-sg"
    Warning     = "This resource is managed by Terraform"
  }
}

resource "aws_security_group" "hosts-int" {
  name        = "${var.env_name}-ecs-hosts-sg-int"
  vpc_id      = "${var.vpc_id}"
  description = "ECS hosts SG int"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name        = "${var.env_name}-ecs-hosts-sg-int"
    Warning     = "This resource is managed by Terraform"
  }
}

