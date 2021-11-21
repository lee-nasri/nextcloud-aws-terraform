resource "aws_subnet" "public-1" {
  # The VPC ID
  vpc_id                        = aws_vpc.vpc.id
  cidr_block                    = var.subnet-public-1-cidrblock
  availability_zone             = var.availability_zone
  map_public_ip_on_launch       = true
  depends_on  = [
                                  aws_vpc.vpc
  ]
  tags = {
      Name                      = "Public subnet 1"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id                        = aws_vpc.vpc.id
  cidr_block                    = var.subnet-private-1-cidrblock
  availability_zone             = var.availability_zone
  depends_on  = [
                                  aws_vpc.vpc
  ]
  tags = {
    Name                        = "Private subnet 1 || database"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id                        = aws_vpc.vpc.id
  cidr_block                    = var.subnet-private-2-cidrblock
  availability_zone             = var.availability_zone
  depends_on  = [
                                  aws_vpc.vpc
  ]
  tags = {
    Name                        = "Private subnet 2 || webserver-database"
  }
}