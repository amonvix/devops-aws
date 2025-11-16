resource "aws_vpc" "eks" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "eks-workshop-vpc"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.eks.id

  tags = {
    Name = "eks-workshop-igw"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.eks.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.eks.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-public-b"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "eks-public-rt"
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "eks-nat-eip"
  }
}

resource "aws_nat_gateway" "this" {
  subnet_id     = aws_subnet.public_a.id
  allocation_id = aws_eip.nat.id

  tags = {
    Name = "eks-nat-gw"
  }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name                               = "eks-private-a"
    "kubernetes.io/role/internal-elb"  = "1"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.eks.id
  cidr_block        = "10.0.101.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name                               = "eks-private-b"
    "kubernetes.io/role/internal-elb"  = "1"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.eks.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = {
    Name = "eks-private-rt"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}
