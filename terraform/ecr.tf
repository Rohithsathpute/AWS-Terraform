# These types of resources are created:
# - AWS ECR image repository

module "queue-worker-repo" {
  source    = "./modules/ecs/ecr_repo"
  role_arn  = "${aws_iam_role.role.arn}"
  repo_name = "queue-worker"
}

data "external" "trigger" {
  program = ["${path.module}/files/dirhash.sh"]

  query {
    directory = "${path.module}/../worker"
  }
}

resource "null_resource" "docker-image-push" {
  count = "${var.docker_build_image}"

  triggers {
    md5 = "${data.external.trigger.result["checksum"]}"
  }

  provisioner "local-exec" {
    command     = "../terraform/files/docker_build.sh ${module.queue-worker-repo.repository_url}"
    working_dir = "../worker"

    environment {
      AWS_DEFAULT_REGION = "${var.region}"
    }
  }
}
