# RDS Parameter Group
resource "aws_rds_cluster_parameter_group" "parametergroup" {
  name   = "engineed-parameter-group"
  family = "aurora-mysql5.7"

  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }

}

# RDS Subnet Group
resource "aws_db_subnet_group" "subnetgroup" {
  name = "engineed-subnet-group"

  subnet_ids = [
    aws_subnet.private3_subnet_1a.id,
    aws_subnet.private4_subnet_1c.id,
  ]
}

####################################################
# RDS Cluster Instance
####################################################

resource "aws_rds_cluster_instance" "instance" {
  cluster_identifier = aws_rds_cluster.aurora_mysql.id

  engine         = aws_rds_cluster.aurora_mysql.engine
  engine_version = aws_rds_cluster.aurora_mysql.engine_version

  instance_class       = "db.t3.small"
  db_subnet_group_name = aws_db_subnet_group.subnetgroup.name
}

####################################################
# RDS cluster config
####################################################

# resource "aws_rds_cluster_parameter_group" "this" {
#   name   = "${local.app_name}-database-cluster-parameter-group"
#   family = "aurora-mysql8.0"

#   parameter {
#     name  = "time_zone"
#     value = "Asia/Tokyo"
#   }
# }

# RDS Aurora MySQL
resource "aws_rds_cluster" "aurora_mysql" {
  engine         = "aurora-mysql"
  engine_version = "5.7.mysql_aurora.2.10.2"
  port           = 3306

  cluster_identifier = "aurora-cluster-engineed"
  master_username    = "admin"
  master_password    = "engineed00001"

  # instance_class          = "db.t3.small"


  # availability_zones = [
  #   "ap-northeast-1a",
  #   "ap-northeast-1c",
  # ]

  db_subnet_group_name            = aws_db_subnet_group.subnetgroup.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.parametergroup.name
  vpc_security_group_ids          = [aws_security_group.rds_sg.id]

  backup_retention_period = 7
  preferred_backup_window = "07:00-09:00"

  deletion_protection = true
  skip_final_snapshot = false

  apply_immediately = true

}
