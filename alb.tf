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

resource "random_integer" "priority" {
  min = 1
  max = 500
  keepers = {
    # Generate a new integer each time we switch to a new listener ARN
    listener_arn = data.terraform_remote_state.alb.backend-listener-arn
  }
}

resource "aws_lb_listener_rule" "static" {
  count              = var.ALB_ATTACH_TO == "backend" ? 1 : 0
  listener_arn = data.terraform_remote_state.alb.backend-listener-arn
  priority     = aws_lb_listener.ba

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
    prio
  }

  condition {
    path_pattern {
      values = ["/static/*"]
    }
  }

  condition {
    host_header {
      values = ["example.com"]
    }
  }
}