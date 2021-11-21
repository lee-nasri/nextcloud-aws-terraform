# variable "provider_profile" {}
variable "region" {}
variable "availability_zone" {}
variable "ami" {}
variable "bucket_name" {}
variable "database_name" {}
variable "database_user" {}
variable "database_pass" {}
variable "admin_user" {}
variable "admin_pass" {}
variable "instance_type" {
    default         = "t2.micro"
    description      = "EC2 instance type"
}

variable "database_endpoint" {
    # IP address of var.database-private-nic-ip and mysql port number
    # if you change private ip of database private network interface
    # (var.database-private-nic-ip) you should change this default value too.
    default         = "172.16.0.53:3306"
    description      = "Database endpoint"
}
variable "database_root_pass" {
    default         = "admin"
    description     = "Databae root password"
}
variable "data_dir" {
    default         = "/var/www/nextcloud/data"
    description     = "Directory of nextcloud metadata inside webserver instance"
}
variable "keyname" {
    # If you want to SSH to the webserver instance, you should change this default value to your aws key-pair.
    default         = "sds-terraform"
    description     = "Key-pair for SSH to webserver ec2 instance"
}

##################### public/private ip variables #####################
variable "webserver-public-nic-ip" {
    default = "172.16.1.50"
    description = "Private IP address of webserver-public-nic"
}

variable "webserver-private-nic-ip" {
    default = "172.16.0.50"
    description = "Private IP address of webserver-private-nic"
}

variable "database-public-nic-ip" {
    default = "172.16.2.50"
    description = "Private IP address of database-public-nic"
}

variable "database-private-nic-ip" {
    default = "172.16.0.53"
    description = "Private IP address of database-private-nic"
}

##################### CIDR block variables #####################

variable "subnet-public-1-cidrblock" {
    default = "172.16.1.0/24"
    description = "CIDR Block of public-1 subnet"
}

variable "subnet-private-1-cidrblock" {
    default = "172.16.2.0/24"
    description = "CIDR Block of private-1 subnet"
}

variable "subnet-private-2-cidrblock" {
    default = "172.16.0.0/24"
    description = "CIDR Block of private-2 subnet"
}

variable "vpc-cidrblock" {
    default = "172.16.0.0/16"
    description = "CIDR Block of virtual private cloud (VPC)"
}