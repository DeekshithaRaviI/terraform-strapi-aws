# ========================================
# Application Load Balancer
# ========================================

resource "aws_lb" "main" {
  name               = "${var.project_name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]
  subnets         = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  enable_deletion_protection = false

  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-alb-${var.environment}"
      Environment = var.environment
    }
  )
}

# ========================================
# Target Group (Strapi)
# ========================================

resource "aws_lb_target_group" "strapi" {
  name        = "${var.project_name}-tg-${var.environment}"
  port        = 1337
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id

  health_check {
  enabled             = true
  path                = "/"              # ✅ Root path instead of /admin
  protocol            = "HTTP"
  matcher             = "200-399"        # ✅ Accept redirects too
  interval            = 60               # ✅ Wait longer between checks
  timeout             = 10               # ✅ Longer timeout
  healthy_threshold   = 2
  unhealthy_threshold = 3                # ✅ More grace attempts
}
  tags = merge(
    var.common_tags,
    {
      Name        = "${var.project_name}-tg-${var.environment}"
      Environment = var.environment
    }
  )
}

# ========================================
# Target Group Attachment
# ========================================

resource "aws_lb_target_group_attachment" "strapi" {
  target_group_arn = aws_lb_target_group.strapi.arn
  target_id        = aws_instance.strapi.id
  port             = 1337
}

# ========================================
# ALB Listener (HTTP)
# ========================================

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi.arn
  }
}
