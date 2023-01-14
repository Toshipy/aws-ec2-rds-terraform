# ALB

resource "aws_alb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  # cross_zone_load_balancing   = true
  # idle_timeout                = 400
  # connection_draining         = true
  # connection_draining_timeout = 400
  # health_check {
  #   healthy_threshold   = 2
  #   unhealthy_threshold = 2
  #   timeout             = 5
  #   target              = "HTTP:80/"
  #   interval            = 30
  # }
  security_groups = [
    aws_security_group.alb_sg.id,
  ]
  subnets = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1c.id,
  ]
}


# Target Group for Contents Server
resource "aws_alb_target_group" "alb_target_group_contents-server" {
  tags = {
    Name = "alb-target-group_contents-server"
  }
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

# Target Group for Manage Server
resource "aws_alb_target_group" "alb_target_group_manage-server" {
  tags = {
    Name = "alb-target-group_manage-server"
  }
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}



# Listener for Contents Server
resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group_contents-server.arn
  }
}

# Listener Group for contents-server
resource "aws_alb_listener_rule" "alb_listener_contents-server" {
  # load_balancer_arn = aws_lb.alb.arn
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 10

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group_contents-server.arn
  }

  condition {
    path_pattern {
      values = ["/manage/*"]
    }
  }
}


# Listener Group for manage-server
resource "aws_alb_listener_rule" "alb_listener_manage-server" {
  # load_balancer_arn = aws_lb.alb.arn
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 20

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group_manage-server.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
