resource "aws_nat_gateway" "nat-gw" {
    connectivity_type     = "public"
    allocation_id         = aws_eip.nat-eip.id
    subnet_id             = aws_subnet.public-1.id
    depends_on            = [aws_internet_gateway.gw, aws_eip.nat-eip, aws_subnet.public-1]
    tags = {
      Name                = "NAT gateway"
    }
}