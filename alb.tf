#resource "aws_lb_target_group" "tg" {
#  name = "${var.COMPONENT}-${var.ENV}"
#  port = var.PORT
#  protocol = "HTTP"
#  vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID
#}
#
#resource "aws_lb_target_group_attachment" "test" {
#  target_group_arn = aws_lb_target_group.test.arn
#  target_id        = aws_instance.test.id
#  port             = 80
#}