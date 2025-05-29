#!/bin/bash

set -e
mkdir -p /var/lib/mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Initialize database only if empty
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# create init.sql and expand env-vars
cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- super
CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'172.%.%.%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_ROOT_USER'@'172.%.%.%' WITH GRANT OPTION;

-- normal
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'172.%.%.%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT SELECT, INSERT, UPDATE, DELETE ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'172.%.%.%';

FLUSH PRIVILEGES;
EOF

# Run the SQL script
exec mariadbd --init-file=/etc/mysql/init.sql --user=mysql

