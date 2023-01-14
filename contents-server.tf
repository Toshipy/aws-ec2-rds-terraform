# EC2 Instance 1

# resource "aws_instance" "contents_server-1" {
#   ami           = "ami-01e94099fb3acf7fa"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.private1_subnet_1a.id
#   user_data = file("initialize.sh")
#   vpc_security_group_ids = [
#     aws_security_group.ec2_sg.id,
#   ]
#   tags = {
#     Name = "Contents-server-1"
#   }

# }

# EC2 Instance 2
# resource "aws_instance" "contents_server-2" {
#   ami           = "ami-01e94099fb3acf7fa"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.private2_subnet_1c.id
#   user_data     = file("initialize.sh")
#   vpc_security_group_ids = [
#     aws_security_group.ec2_sg.id,
#   ]
#   tags = {
#     Name = "Contents-server-2"
#   }

# }

