resource "aws_sqs_queue" "mod" {
  name                      = "${var.queue_name}"
  delay_seconds             = "${var.delay_seconds}"
  max_message_size          = "${var.max_message_size}"
  message_retention_seconds = "${var.message_retention_seconds}"
  receive_wait_time_seconds = "${var.receive_wait_time_seconds}"

  tags                      = "${var.tags}"
}

resource "aws_sqs_queue_policy" "mod" {
  queue_url = "${aws_sqs_queue.mod.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal":{"AWS":"${var.iam_user_role_arn}"},
      "Action": [
         "sqs:*"
      ],
      "Resource": "${aws_sqs_queue.mod.arn}"
    }
  ]
}
POLICY
}
