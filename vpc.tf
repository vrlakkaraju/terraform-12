# VPC 
resource "aws_vpc" "vpc1"{
  cidr_block = "10.0.0.0/16"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "vpc1"
    Source = "terraform"
  }
}

# 2 public subnets 
resource "aws_subnet" "public-1"{
  vpc_id = "${aws_vpc.vpc1.id}"
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public subnet 1"
  }
}

resource "aws_subnet" "public-2"{
  vpc_id = "${aws_vpc.vpc1.id}"
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public subnet 2"
  }
}

# 2 private subnets

resource "aws_subnet" "private-1"{
  vpc_id = "${aws_vpc.vpc1.id}"
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "private subnet 1"
  }
}

resource "aws_subnet" "private-2"{
  vpc_id = "${aws_vpc.vpc1.id}"
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "private subnet 2"
  }
}

# Internet gateway

resource "aws_internet_gateway" "igw"{
  vpc_id = "${aws_vpc.vpc1.id}"
  tags = {
    Name = "Internet GateWay"
  }
}

# public route table

resource "aws_route_table" "public_rt1"{
  vpc_id = "${aws_vpc.vpc1.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = "public route table"
  }
}

# Route table associations


resource "aws_route_table_association" "public-1"{
  subnet_id = "${aws_subnet.public-1.id}"
  route_table_id = "${aws_route_table.public_rt1.id}"
}

resource "aws_route_table_association" "public-2"{
  subnet_id = "${aws_subnet.public-2.id}"
  route_table_id = "${aws_route_table.public_rt1.id}"
}


