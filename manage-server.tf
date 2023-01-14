# # EC2 Instance 3
# resource "aws_instance" "manage_server" {
#   ami           = "ami-01e94099fb3acf7fa"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.private1_subnet_1a.id
#   vpc_security_group_ids = [
#     aws_security_group.ec2_sg.id,
#   ]
#   tags = {
#     Name = "Manage-server"
#   }

# }
