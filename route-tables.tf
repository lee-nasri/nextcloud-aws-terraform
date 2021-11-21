################################## route table ##################################

resource "aws_route_table" "public-route-table" {
    vpc_id            = aws_vpc.vpc.id

    route {
        cidr_block      = "0.0.0.0/0"
        gateway_id      = aws_internet_gateway.gw.id
    }

    depends_on  = [
                        aws_vpc.vpc, 
                        aws_internet_gateway.gw 
    ]

    tags = {
        Name            = "Public route table"
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id            = aws_vpc.vpc.id

    route {
        cidr_block      = "0.0.0.0/0"
        nat_gateway_id  = aws_nat_gateway.nat-gw.id
    }

    depends_on = [
        aws_nat_gateway.nat-gw,
        aws_vpc.vpc,
        aws_internet_gateway.gw
    ]

    tags = {
        Name            = "Private route table"
    }
}

################################## route table assocation ##################################
resource "aws_route_table_association" "public-route" {
   subnet_id      = aws_subnet.public-1.id
   route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-route" {
   subnet_id      = aws_subnet.private-1.id
   route_table_id = aws_route_table.private-route-table.id
   depends_on = [
                    aws_route_table.private-route-table,
                    aws_subnet.private-1
    ]
}