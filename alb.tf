resource "aws_lb_target_group" "frontend" {
  name = "${var.COMPONENT}-${var.ENV}"
  port = var.PORT
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID
}
