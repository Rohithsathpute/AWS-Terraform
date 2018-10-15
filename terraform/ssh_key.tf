# These types of resources are created:
# Amazon EC2 Key Pair

resource "aws_key_pair" "prod-key" {
  key_name   = "${var.project_name}-${var.environment_name}"
  public_key = "${file("./files/insecure_key.pub")}"
}
