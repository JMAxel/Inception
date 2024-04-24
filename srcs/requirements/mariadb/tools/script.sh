#!/bin/bash


service mariadb start

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > hold.sql
echo "CREATE USER IF NOT EXISTS '$USER'@'%' IDENTIFIED BY '$PWD' ;" > hold.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_NAME-'@'%' ;" > hold.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234' ;" > hold.sql
echo "FLUSH PRIVILEGES ;" > hold.sql

mariadb < hold.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld