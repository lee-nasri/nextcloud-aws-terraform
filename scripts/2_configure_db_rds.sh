#!/bin/bash

# RDS config
cat << EOF > nextcloud/config/autoconfig.php
<?php
\$AUTOCONFIG = array(
  "dbtype"        => "mysql",
  "dbname"        => "${database_name}",
  "dbuser"        => "${database_user}",
  "dbpass"        => "${database_pass}",
  "dbhost"        => "${database_endpoint}",
  "dbtableprefix" => "",
  "adminlogin"    => "${admin_user}",
  "adminpass"     => "${admin_pass}",
  "directory"     => "${data_dir}",
);
EOF