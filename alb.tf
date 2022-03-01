resource "aws_lb_target_group" "frontend" {
  name = "${var.COMPONENT}-${var.ENV}"
  port = 80
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID
}
