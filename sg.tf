# ALB Security Group
resource "aws_security_group" "alb_sg" {
  description = "alb security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_security_group_rule" "alb_in_http" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
}

# resource "aws_security_group_rule" "alb_out_tcp3000" {
#   security_group_id = aws_security_group.alb_sg.id
#   type = "ingress"
#   protocol = "tcp"
#   from_port = 80
#   to_port = 80
#   cidr_blocks = [ "0.0.0.0/0" ]
# }

# EC2 security group
resource "aws_security_group" "ec2_sg" {
  description = "ec2 security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "ec2-sg"
  }
}

resource "aws_security_group_rule" "ec2_in_http" {
  security_group_id        = aws_security_group.ec2_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.alb_sg.id
}

# RDS Security Group
resource "aws_security_group" "rds_sg" {
  description = "rds security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "rds-sg"
  }
}

resource "aws_security_group_rule" "rds_in_http" {
  security_group_id        = aws_security_group.rds_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.ec2_sg.id

}
