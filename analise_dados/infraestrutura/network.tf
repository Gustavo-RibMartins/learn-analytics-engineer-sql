###################### VPC ####################

resource "aws_vpc" "rsc_vpc_estudo_sql" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-learn-eng-anl-sql"
  }
}

############## Subnet Publica #################

resource "aws_subnet" "rsc_subn_pub_1a_estd_sql_pstg" {
  vpc_id            = aws_vpc.rsc_vpc_estudo_sql.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "subn-pub-1a-learn-eng-anl-sql"
  }
}

resource "aws_subnet" "rsc_subn_pub_1b_estd_sql_pstg" {
  vpc_id            = aws_vpc.rsc_vpc_estudo_sql.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "subn-pub-1b-learn-eng-anl-sql"
  }
}

############## Internet Gateway ###############

resource "aws_internet_gateway" "rsc_igw_vpc_estd_sql" {
  vpc_id = aws_vpc.rsc_vpc_estudo_sql.id

  tags = {
    Name = "igw-learn-eng-anl-sql"
  }
}

################ Route Table ##################

resource "aws_route_table" "rsc_rt_subn_estd_sql_pstg" {
  vpc_id = aws_vpc.rsc_vpc_estudo_sql.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rsc_igw_vpc_estd_sql.id
  }

  tags = {
    Name = "rt-learn-eng-anl-sql"
  }
}

##### Associacao da Route Table com Subnet #######

resource "aws_route_table_association" "rsc_rt_subn_1a_asso" {
  subnet_id      = aws_subnet.rsc_subn_pub_1a_estd_sql_pstg.id
  route_table_id = aws_route_table.rsc_rt_subn_estd_sql_pstg.id
}

resource "aws_route_table_association" "rsc_rt_subn_1b_asso" {
  subnet_id      = aws_subnet.rsc_subn_pub_1b_estd_sql_pstg.id
  route_table_id = aws_route_table.rsc_rt_subn_estd_sql_pstg.id
}
