data "template_cloudinit_config" "cloudinit-nextcloud" {
  gzip          = false
  base64_encode = false

  # 1. Download nextcloud and install dependencies
  part {
    content_type = "text/x-shellscript"
    content = templatefile("./scripts/1_download_nextcloud_and_deps.sh", {})
  }

  # 2. Configure Nextcloud database in RDS
  part {
    content_type = "text/x-shellscript"
    content = templatefile("./scripts/2_configure_db_rds.sh", {
                    database_name = var.database_name, 
                    database_user = var.database_user, 
                    database_pass = var.database_pass, 
                    database_endpoint = var.database_endpoint,
                    admin_user = var.admin_user,
                    admin_pass = var.admin_pass,
                    data_dir = var.data_dir,
                    
    })
  }

  # 3. Configure Nextcloud datastore in S3
  part {
    content_type = "text/x-shellscript"
    content = templatefile("./scripts/3_configure_datastore_s3.sh", {
                    region = var.region,
                    s3_bucket_name = var.bucket_name,
                    s3_access_key = aws_iam_access_key.nextcloud-s3-access_key.id
                    s3_secret_key = aws_iam_access_key.nextcloud-s3-access_key.secret
    })
  }

  # 4. Install Apache conf for Nextcloud
  part {
    content_type = "text/x-shellscript"
    content = templatefile("./scripts/4_nextcloud_apache_conf.sh", {})
  }

  # 5. Finish Apache configuration and start service
  part {
    content_type = "text/x-shellscript"
    content = templatefile("./scripts/5_finish_config_and_start.sh", {})
  }
}


data "template_cloudinit_config" "cloudinit-mariadb" {
  gzip          = false
  base64_encode = false


  # 1. Install mariaDB
  part {
    content_type = "text/x-shellscript"
    content = templatefile("./scripts/database.sh", {
                    database_root_pass = var.database_root_pass, 
                    database_name = var.database_name, 
                    database_user = var.database_user, 
                    database_pass = var.database_pass, 
    })
  }
}