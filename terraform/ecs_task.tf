# These types of resources are created:
# - Amazon ECS Task Definition

resource "aws_ecs_task_definition" "worker" {
  family = "${var.project_name}-${var.environment_name}-worker"

  container_definitions = <<DEFINITIONS
[
  {
    "memoryReservation": ${var.ecs_task_memory},
    "essential": true,
    "image": "${module.queue-worker-repo.repository_url}",
    "name": "${var.project_name}-${var.environment_name}-worker",
    "environment": [
      {
        "name": "AWS_SQS_QUEUE_NAME",
        "value": "${module.commands-queue.name}"
      },
      {
        "name": "AWS_DEFAULT_REGION",
        "value": "${var.region}"
      }
    ]
  }
]
DEFINITIONS
}

