resource "aws_eip" "nat-eip" {
  vpc                       = true
  depends_on                = [aws_internet_gateway.gw]
  tags = {
    Name                    = "NAT EIP"
  }
}

resource "aws_eip" "webserver-eip" {
    vpc                           = true
    depends_on                    = [aws_internet_gateway.gw]
    network_interface             = aws_network_interface.webserver-public-nic.id
    associate_with_private_ip     = var.webserver-public-nic-ip
    tags = {
        Name                        = "Webserver EIP"
    }
}