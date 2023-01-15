resource "aws_db_instance" "mysql_standalone" {
  engine = "mysql"
  engine_version = "8.0.20"
  
  # identifier =
  username = "admin"
  password  = "00001"

  instance_class = "db.t2.micro"

  allocated_storage = 20
  max_allocated_storage = 50
  storage_type = "gp2"
  storage_encrypted = true

  multi_az = true
  availability_zone = "ap_northeast_1a"
  # db_subnet_group_name = aws_db_sbunet_group
  vpc_security_group_ids = [ aws_security_group.rds_sg.id ]
  publicly_accesible = false
  port = 3306

  name = "engineed"
  parameter_group_name = aws_db_parameter_group.
  option_group_name = aws_db_option_group.

  backup_window = "03:00 - 04:00"
  backup_retention_period = 7
  maintenance_window = "mon:02:00 - Mon:04:00"
  auto_minor_version_upgrade = false

  deletion_protection = true
  skip_final_snapshot = false

  apply_immediately = true

  tages {
    Name = "RDS-engineed"
  }
}
