variable "queue_name" {}
variable "iam_user_role_arn" {}

variable "tags" {
  type = "map"
}

variable "delay_seconds" {
  default = 20
}

variable "max_message_size" {
  default = 2048
}

variable "message_retention_seconds" {
  default = 86400
}

variable "receive_wait_time_seconds" {
  default = 10
}
