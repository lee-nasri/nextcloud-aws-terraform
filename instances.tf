resource "aws_instance" "webserver-instance" {
    ami                         = var.ami 
    instance_type               = var.instance_type
    availability_zone           = var.availability_zone
    iam_instance_profile        = aws_iam_instance_profile.webserver-profile.name
    key_name                    = var.keyname

    network_interface {
        device_index            = 0
        network_interface_id    = aws_network_interface.webserver-public-nic.id
    }

    network_interface {
        device_index            = 1
        network_interface_id    = aws_network_interface.webserver-private-nic.id
    }

    user_data                   = "${data.template_cloudinit_config.cloudinit-nextcloud.rendered}"
    tags = {
        Name                    = "Nextcloud's webserver ec2 instance"
    }
}


resource "aws_instance" "database-instance" {
    ami                         = var.ami 
    instance_type               = var.instance_type
    availability_zone           = var.availability_zone
    iam_instance_profile        = aws_iam_instance_profile.database-profile.name
    key_name                    = var.keyname

    network_interface {
        device_index            = 0
        network_interface_id    = aws_network_interface.database-public-nic.id
    }

    network_interface {
        device_index            = 1
        network_interface_id    = aws_network_interface.database-private-nic.id
    }

    user_data                   = "${data.template_cloudinit_config.cloudinit-mariadb.rendered}"
    tags = {
        Name                    = "Nextcloud's database ec2 instance"
    }
    depends_on = [
                                aws_network_interface.database-public-nic,
                                aws_network_interface.database-private-nic,
                                aws_route_table_association.private-route
    ]
}

resource "aws_s3_bucket" "nextcloud-storage" {
    bucket                      = var.bucket_name
    acl                         = "private"
    force_destroy               = true
    tags = {
        Name                    = "Nextcloud storage"
        Environment             = "Dev"
    } 
}

# Allow access to the bucket only to the nextcloud user and the terraform user
resource "aws_s3_bucket_policy" "nextcloud_s3_datastore_policy" {

  bucket = aws_s3_bucket.nextcloud-storage.id

  policy = <<S3_POLICY
{
  "Id": "NextcloudS3Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllActions",
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": [ 
          "${aws_s3_bucket.nextcloud-storage.arn}",
          "${aws_s3_bucket.nextcloud-storage.arn}/*" 
        ],
      "Principal": {
        "AWS": [
            "${aws_iam_user.nextcloud-s3.arn}",
            "${data.aws_caller_identity.terraform_user.arn}"
        ]
      }
    }
  ]
}
S3_POLICY
}