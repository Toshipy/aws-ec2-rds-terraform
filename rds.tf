# RDS Parameter Group
resource "aws_db_parameter_group" "mysql_standalone_parametergroup" {
  name   = "engineed-parameter-group"
  family = "mysql8.0"

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }
}

# RDS Option Group
resource "aws_db_option_group" "mysql_standalone_optiongroup" {
  name                 = "engineed-option-group"
  engine_name          = "mysql"
  major_engine_version = "8.0"
}

# RDS Subnet Group
resource "aws_db_subnet_group" "mysql_standalone_subnetgroup" {
  name = "engineed-subnet-group"
  subnet_ids = [
    aws_subnet.private3_subnet_1a.id,
    aws_subnet.private4_subnet_1c.id,
  ]
  tags = {
    Name = "RDS-SubnetGroup"
  }
}


resource "aws_rds_cluster" "aurora_mysql" {
  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.03.2"

  cluster_identifier      = "aurora-cluster-engineed"
  master_username = "admin"
  master_password = "00001"

  db_cluster_instance_class = "db.t3.micro"

  allocated_storage     = 20
  storage_type          = "io1"
  iops = 1000
  storage_encrypted     = true

  # multi_az          = true
  availability_zones = [
    "ap_northeast_1a",
    "ap_northeast_1c",
  ]

  db_subnet_group_name = aws_db_subnet_group.mysql_standalone_subnetgroup.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  # publicly_accessible     = false
  port                   = 3306

  # db_name = "Engineed00374"
  # parameter_group_name = aws_db_parameter_group.mysql_standalone_parametergroup.name
  # option_group_name = aws_db_option_group.mysql_standalone_optiongroup.name

  backup_retention_period    = 7
  preferred_backup_window = "07:00-09:00"

  deletion_protection = true
  skip_final_snapshot = false

  apply_immediately = true

}
