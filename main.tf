# Public subnet 1
resource "aws_subnet" "Test-public-sub1" {
  vpc_id            = aws_vpc.Prod-rock-VPC.id
  cidr_block        = var.cidr-for-Test-public-sub1
  availability_zone = var.AZ-1

  tags = {
    Name = "Test-public-sub1"
  }
}


# Public subnet 2
resource "aws_subnet" "Test-public-sub2" {
  vpc_id            = aws_vpc.Prod-rock-VPC.id
  cidr_block        = var.cidr-for-Test-public-sub2
  availability_zone = var.AZ-2

  tags = {
    Name = "Test-public-sub2"
  }
}


# Private subnet 1
resource "aws_subnet" "Test-priv-sub1" {
  vpc_id            = aws_vpc.Prod-rock-VPC.id
  cidr_block        = var.cidr-for-Test-priv-sub1
  availability_zone = var.AZ-3

  tags = {
    Name = "Test-priv-sub1"
  }
}


# Private subnet 2
resource "aws_subnet" "Test-priv-sub2" {
  vpc_id            = aws_vpc.Prod-rock-VPC.id
  cidr_block        = var.cidr-for-Test-priv-sub2
  availability_zone = var.AZ-3

  tags = {
    Name = "Test-priv-sub2"
  }
}


# Public route table
resource "aws_route_table" "Test-public-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-public-route-table"
  }
}


# Private route table
resource "aws_route_table" "Test-private-route-table" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-private-route-table"
  }
}


# Public route table associations
resource "aws_route_table_association" "public-route-table-association" {
  subnet_id      = aws_subnet.Test-public-sub1.id
  route_table_id = aws_route_table.Test-public-route-table.id
}

resource "aws_route_table_association" "public-route-table-association2" {
  subnet_id      = aws_subnet.Test-public-sub2.id
  route_table_id = aws_route_table.Test-public-route-table.id
}


# Private route table association
resource "aws_route_table_association" "private-route-table-association" {
  subnet_id      = aws_subnet.Test-priv-sub1.id
  route_table_id = aws_route_table.Test-private-route-table.id
}

resource "aws_route_table_association" "private-route-table-association2" {
  subnet_id      = aws_subnet.Test-priv-sub2.id
  route_table_id = aws_route_table.Test-private-route-table.id
}


# Internet gateway
resource "aws_internet_gateway" "Test-IGW" {
  vpc_id = aws_vpc.Prod-rock-VPC.id

  tags = {
    Name = "Test-IGW"
  }
}


# AWS Route IGW-Public route table
resource "aws_route" "Test-igw-association" {
  route_table_id         = aws_route_table.Test-public-route-table.id
  gateway_id             = aws_internet_gateway.Test-IGW.id
  destination_cidr_block = var.IGW_destination_cidr_block
}

# Create Elastic IP
resource "aws_eip" "Prod-rock-EIP" {
  vpc = var.EIP
}

# Create NAT gateway
resource "aws_nat_gateway" "Test-Nat-gateway" {
  allocation_id = aws_eip.Prod-rock-EIP.id
  subnet_id     = aws_subnet.Test-public-sub1.id

  tags = {
    Name = "Test-Nat-gateway"
  }
}


# Associating NATgateway with private route table
resource "aws_route" "Test-Nat-association" {
  route_table_id         = aws_route_table.Test-private-route-table.id
  nat_gateway_id         = aws_nat_gateway.Test-Nat-gateway.id
  destination_cidr_block = var.Nat-gateway_destination_cidr_block
}