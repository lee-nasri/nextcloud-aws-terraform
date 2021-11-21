resource "aws_network_interface" "webserver-public-nic" {
    subnet_id           = aws_subnet.public-1.id
    private_ips         = ["${var.webserver-public-nic-ip}"]
    security_groups     = [aws_security_group.webserver.id]
    description         = "Webserver network interface for public communication (Webserver-Internet)"

    tags = {
        Name            = "Webserver public network interface"
    }
}  

resource "aws_network_interface" "webserver-private-nic" {
    # private-2 is a subnet for webserver-database private communication
    subnet_id           = aws_subnet.private-2.id
    private_ips         = ["${var.webserver-private-nic-ip}"]
    security_groups     = [aws_security_group.webserver-database.id]
    description         = "Webserver network interface for private communication (Webserver-Database)"

    tags = {
        Name            = "Webserver private network interface"
    }
}  

resource "aws_network_interface" "database-public-nic" {
    # private-1 is database's subnet
    subnet_id       = aws_subnet.private-1.id
    private_ips     = ["${var.database-public-nic-ip}"]
    security_groups = [aws_security_group.database.id]
    depends_on = [
        aws_subnet.private-1,
        aws_security_group.database
    ]

    tags = {
        Name          = "database public network interface"
    }
}  

resource "aws_network_interface" "database-private-nic" {
    # private-2 is a subnet for webserver-database private communication
    subnet_id       = aws_subnet.private-2.id
    private_ips     = ["${var.database-private-nic-ip}"]
    security_groups = [aws_security_group.webserver-database.id]

    tags = {
        Name          = "database private network interface"
    }
}  