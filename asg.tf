#Contents Server Auto Scaling
resource "aws_autoscaling_group" "asg-contents-server" {

  name                      = "asg-contents-server"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    aws_subnet.private1_subnet_1a.id,
    aws_subnet.private2_subnet_1c.id
  ]
  target_group_arns = [
    aws_alb_target_group.alb_target_group_contents-server.arn
  ]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.contents-server_launch_template.id
        version            = "$Latest"
      }
      override {
        instance_type = "t2.micro"
      }
    }
  }
}


#Manage Server Auto Scaling
resource "aws_autoscaling_group" "asg-manage-server" {

  name                      = "asg-manage-server"
  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    aws_subnet.private1_subnet_1a.id,
    aws_subnet.private2_subnet_1c.id
  ]
  target_group_arns = [
    aws_alb_target_group.alb_target_group_manage-server.arn
  ]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.manage-server_launch_template.id
        version            = "$Latest"
      }
      override {
        instance_type = "t2.micro"
      }
    }
  }
}



# Launch Template Contents Server
resource "aws_launch_template" "contents-server_launch_template" {
  update_default_version = true
  name                   = "contents-server_launch_template"
  image_id               = "ami-01e94099fb3acf7fa"
  instance_type          = "t2.micro"
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Contents-server_launch_template"
    }
  }

  network_interfaces {
    security_groups = [
      aws_security_group.ec2_sg.id
    ]
    delete_on_termination = true
  }
  user_data = filebase64("initialize.sh")
}

# Launch Template Manage Server
resource "aws_launch_template" "manage-server_launch_template" {
  update_default_version = true
  name                   = "manage-server_launch_template"
  image_id               = "ami-01e94099fb3acf7fa"
  instance_type          = "t2.micro"
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Manage-server_launch_template"
    }
  }

  network_interfaces {
    security_groups = [
      aws_security_group.ec2_sg.id
    ]
    delete_on_termination = true
  }
  user_data = filebase64("initialize.sh")

}

# #Scale-out
# resource "aws_autoscaling_policy" "asg_scale_out" {
#   name                   = "Instance-ScaleOut-CPU-High"
#   scaling_adjustment     = 1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.asg.name
# }

# #Scale-in
# resource "aws_autoscaling_policy" "asg_scale_in" {
#   name                   = "Instance-ScaleIn-CPU-Low"
#   scaling_adjustment     = -1
#   adjustment_type        = "ChangeInCapacity"
#   cooldown               = 300
#   autoscaling_group_name = aws_autoscaling_group.asg.name
# }

# # CloudWatch Alarm
# resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
#   alarm_name          = "dev-api-CPU-Utilization-High-30"
#   comparison_operator = "GreaterThanOrEqualToThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "30"
#   # dimensions {
#   #   AutoScalingGroupName = aws_autoscaling_group.asg.name
#   # }
#   alarm_actions = aws_autoscaling_policy.asg_scale_out.arn
# }

# resource "aws_cloudwatch_metric_alarm" "asg_cpu_low" {
#   alarm_name          = "dev-api-CPU-Utilization-Low-5"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = "1"
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/EC2"
#   period              = "300"
#   statistic           = "Average"
#   threshold           = "5"
#   # dimensions {
#   #   AutoScalingGroupName = aws_autoscaling_group.asg.name
#   # }
#   alarm_actions = aws_autoscaling_policy.asg_scale_in.arn
# }
