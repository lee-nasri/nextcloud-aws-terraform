resource "aws_security_group" "webserver" {
    name        = "webserver security group"
    description = "Allow inbound-outbound traffic for web server"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "Webserver security group"
    }

    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 

    ingress {
        description = "HTTPS"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }
} 

resource "aws_security_group" "database" {
    name        = "database security group"
    description = "Allow outbound traffic for database"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "Database security group"
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

  depends_on = [
      aws_vpc.vpc,
      aws_subnet.public-1,
      aws_subnet.private-1
    ]
} 

resource "aws_security_group" "webserver-database" {
    name                        = "webserver-database security group"
    description                 = "Allow private inbound traffic for webserver-database communication"
    vpc_id                      = aws_vpc.vpc.id
    depends_on = [
                                  aws_vpc.vpc
    ]
    tags = {
        Name                    = "webserver-databae security"
    }

    ingress {
        description             = "mysql"
        from_port               = 3306
        to_port                 = 3306
        protocol                = "tcp"
        cidr_blocks             = ["${var.subnet-private-2-cidrblock}"]
    } 

    egress {
        from_port               = 3306
        to_port                 = 3306
        protocol                = "tcp"
        cidr_blocks             = ["${var.subnet-private-2-cidrblock}"]
    }
} 