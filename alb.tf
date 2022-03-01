resource "aws_lb_target_group" "tg" {
  name = "${var.COMPONENT}-${var.ENV}"
  port = var.PORT
  protocol = "HTTP"
  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  count            = length(local.ALL_INSTANCE_IDS)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = element(local.ALL_INSTANCE_IDS, count.index )
  port             = var.PORT
}
