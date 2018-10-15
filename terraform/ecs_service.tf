# These types of resources are created:
# - Amazon Elastic Container Service

resource "aws_ecs_service" "worker" {
  name            = "${var.project_name}-${var.environment_name}-${aws_ecs_task_definition.worker.revision}"
  cluster         = "${aws_ecs_cluster.worker-ecs.id}"
  task_definition = "${aws_ecs_task_definition.worker.arn}"
  desired_count   = "${var.ecs_task_desired_count}"
}
