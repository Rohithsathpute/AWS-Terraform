# These types of resources are created:
# - AWS IAM Instance Profile
# - AWS IAM Role
# - AWS IAM Role Policy

resource "aws_iam_instance_profile" "profile" {
  name  = "tf-${var.project_name}-${var.environment_name}-instance-profile"
  role = "${aws_iam_role.role.name}"
}


resource "aws_iam_role" "role" {
  name = "tf-${var.project_name}-${var.environment_name}-role"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    },
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ecs" {
  name = "tf-${var.project_name}-${var.environment_name}-ecs"
  role = "${aws_iam_role.role.id}"
  policy = "${data.aws_iam_policy_document.ecs.json}"
}

data "aws_iam_policy_document" "ecs" {
  # ECS
  statement {
    effect = "Allow"
    resources = [
      "*",
    ]
    actions = [
      "ecs:CreateCluster",
      "ecs:RegisterContainerInstance",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:StartTelemetrySession",
      "ecs:Submit*",
      "ecs:Poll",
      "ecs:StartTask"
    ]
  }

  # ECR
  statement {
    effect = "Allow"
    resources = [
      "*",
    ]
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken",
    ]
  }

  # CloudWatch Logs
  statement {
    effect = "Allow"
    resources = [
      "arn:aws:logs:*:*:*",
    ]
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams",
    ]
  }
}
