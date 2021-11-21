resource "aws_vpc" "vpc" {
  cidr_block                = var.vpc-cidrblock
  enable_dns_hostnames      = true
  tags = {
    Name                    = "Terraform VPC"
  }
}