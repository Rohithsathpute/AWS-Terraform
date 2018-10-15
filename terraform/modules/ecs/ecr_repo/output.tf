output "arn" {
  value = "${aws_ecr_repository.mod.arn}"
}

output "repository_url" {
  value = "${aws_ecr_repository.mod.repository_url}"
}
