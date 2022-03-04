resource "aws_lb_target_group" "tg" {
  name      = "${var.COMPONENT}-${var.ENV}"
  port      = var.PORT
  protocol  = "HTTP"
  vpc_id    = data.terraform_remote_state.vpc.outputs.VPC_ID
  health_check {
    enabled             = true
    path                = "/health"
    unhealthy_threshold = 2
    interval            = 5
    timeout             = 4
  }
}

resource "aws_lb_target_group_attachment" "tg-attach" {
  count            = length(local.ALL_INSTANCE_IDS)
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = element(local.ALL_INSTANCE_IDS, count.index )
  port             = var.PORT
}

resource "aws_lb_listener" "frontend" {
  count              = var.ALB_ATTACH_TO == "frontend" ? 1 : 0
  load_balancer_arn  = data.terraform_remote_state.alb.outputs.frontend-arn
  port               = "80"
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

resource "aws_lb_listener" "backend"{
  count              = var.ALB_ATTACH_TO == "backend" ? 1 : 0
  load_balancer_arn  = data.terraform_remote_state.alb.outputs.frontend-arn
  port               = "8080"
  protocol           = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}
