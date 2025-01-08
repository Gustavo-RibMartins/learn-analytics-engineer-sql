resource "aws_db_subnet_group" "rsc_db_subn" {
  name = "main"
  subnet_ids = [
    aws_subnet.rsc_subn_pub_1a_estd_sql_pstg.id,
    aws_subnet.rsc_subn_pub_1b_estd_sql_pstg.id
  ]

  tags = {
    Name = "Subnet Group do RDS Postgres"
  }
}

resource "aws_db_instance" "rsc_rds_estd_sql_pstg" {
  allocated_storage      = 20
  db_name                = "sqlPostgres"
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  username               = "pgAdministrador"
  password               = "pgAdministrador"
  db_subnet_group_name   = aws_db_subnet_group.rsc_db_subn.name
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rsc_sg_estd_sql_pstg.id]
  multi_az               = false
  publicly_accessible    = true
  tags = {
    Name = "rds-learn-eng-anl-sql"
  }
}
