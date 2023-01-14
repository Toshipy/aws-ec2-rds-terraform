# VPC
resource "aws_vpc" "vpc" {
  cidr_block                       = "192.168.0.0/20"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
}


# Subnet public_subnet_1a
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "ALB"
  }

}

# Subnet 1.private_subnet_1a
resource "aws_subnet" "private1_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "EC2-1"
  }
}

# Subnet 2.private_subnet_1c
resource "aws_subnet" "private2_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.3.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "EC2-2"
  }
}

# Subnet 3.private_subnet_1a - RDS
resource "aws_subnet" "private3_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "192.168.4.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "RDS-1"
  }

}

# Subnet 4.private_subnet_1a - RDS
resource "aws_subnet" "private4_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "192.168.5.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name = "RDS-1"
  }

}

# Public Route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_rt_1a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.public_subnet_1a.id
}


# Private Route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private-rt"
  }
}

resource "aws_route_table_association" "private1_rt_1a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private1_subnet_1a.id
}

resource "aws_route_table_association" "private2_rt_1c" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private2_subnet_1c.id
}

resource "aws_route_table_association" "private3_rt_1a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private3_subnet_1a.id
}

resource "aws_route_table_association" "private4_rt_1c" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = aws_subnet.private4_subnet_1c.id
}
