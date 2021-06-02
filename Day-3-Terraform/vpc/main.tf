resource "aws_vpc" "vpc" {
  cidr_block      = "10.0.0.0/16"

  tags = {
    Name = "vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = "10.0.0.0/17"
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block = "10.0.128.0/17"

  tags = {
    Name = "private"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gw"
  }
}
resource "aws_eip" "lb" {
  instance = aws_instance.web.id
  vpc      = true
  tags = {
    Name = "eip"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "route-table-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route-table-public"
  }
}

resource "aws_route_table" "route-table-private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "route-table-public"
  }
}

resource "aws_route_table_association" "rta-public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route-table-private.id
}

resource "aws_route_table_association" "rta-private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.route-table-private.id
}

resource "aws_security_group" "private_tls" {
  name        = "private_tls"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "private_tls"
  }
}

resource "aws_security_group" "public_tls" {
  name        = "public_tls"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
   
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "public_tls"
  }
}
