#!/bin/bash
set -e
mkdir -p /var/lib/mysql /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Run the SQL script
exec mariadbd --init-file=/etc/mysql/init.sql --user=mysql

