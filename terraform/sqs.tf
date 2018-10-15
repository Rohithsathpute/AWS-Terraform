# These types of resources are created:
# - Amazon Simple Queue Service
# - Amazon SQS Policy

module "commands-queue" {
  source            = "./modules/sqs"
  queue_name        = "${var.project_name}-${var.environment_name}-queue"
  iam_user_role_arn = "${aws_iam_role.role.arn}"

  tags {
    "Terraform"   = "true"
    "ProjectName" = "${var.project_name}"
    "Environment" = "${var.environment_name}"
  }
}

output "queue_name" {
  value = "${module.commands-queue.name}"
}
