resource "aws_security_group" "rsc_sg_estd_sql_pstg" {
  name        = "secgp-learn-eng-anl-sql"
  description = "Allow Postgres inbound traffic"
  vpc_id      = aws_vpc.rsc_vpc_estudo_sql.id

  ingress {
    description      = "Allow Postgres"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "secgp-learn-eng-anl-sql"
  }
}