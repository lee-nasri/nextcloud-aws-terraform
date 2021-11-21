resource "aws_iam_role" "webserver-role" {
    name = "webserver_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action  = "sts:AssumeRole"
                Effect  = "Allow"
                Sid     = ""
                Principal = {
                    Service : "ec2.amazonaws.com"
                }
            },
        ]
    })
}

# reference 0
resource "aws_iam_role_policy" "webserver-policy" {
    name = "webserver_policy"
    role = aws_iam_role.webserver-role.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "ec2:*"
                ]
                Effect = "Allow"
                Resource = "*"
            }
        ]
    })
}


resource "aws_iam_instance_profile" "webserver-profile" {
    name = "web_profile"
    role = aws_iam_role.webserver-role.name
}

# reference 2
resource "aws_iam_role" "database-role" {
    name = "db_role"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action  = "sts:AssumeRole"
                Effect  = "Allow"
                Sid     = ""
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            },
        ]
    })
}

resource "aws_iam_role_policy" "database-policy" {
    name = "db_policy"
    role = aws_iam_role.database-role.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = [
                    "ec2:*",
                ]
                Effect = "Allow"
                Resource = "*"
            },
        ]
    })
}

# reference 1
resource "aws_iam_instance_profile" "database-profile" {
    name = "database_profile"
    role = aws_iam_role.database-role.name
}

# reference
resource "aws_iam_user" "s3" {
    name = "loadbalancer"
    path = "/system/"

    tags = {
        Name = "s3 user"
    }
}

##########

data "aws_caller_identity" "terraform_user" {}

# By default, a new IAM user has no permissions, so it can do nothing
resource "aws_iam_user" "nextcloud-s3" {
  name = "terraform-nextcloud-s3"
}

resource "aws_iam_access_key" "nextcloud-s3-access_key" {
  user = aws_iam_user.nextcloud-s3.name
}
