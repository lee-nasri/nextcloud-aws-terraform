#!/bin/bash

# S3 config
cat << EOF > nextcloud/config/storage.config.php
<?php
\$CONFIG = array (
  "objectstore" => array( 
      "class" => "OC\\Files\\ObjectStore\\S3",
      "arguments" => array(
        "bucket" => "${s3_bucket_name}",
        "key"    => "${s3_access_key}",
        "secret" => "${s3_secret_key}",
        "use_ssl" => true,
        "region" => "${region}"
      ),
    ),
  );
EOF