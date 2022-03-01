resource "aws_lb_target_group" "frontend" {
  name = "${var.COMPONENT}-${var.ENV}"
  port = 80
  protocol = "HTTP"
}
