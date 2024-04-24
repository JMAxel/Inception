#!/bin/bash


service mariadb start

echo "CREATE DATABASE IF NOT EXISTS Inception ;" > hold.sql
echo "CREATE USER IF NOT EXISTS 'jogomes-'@'%' IDENTIFIED BY '123456' ;" > hold.sql
echo "GRANT ALL PRIVILEGES ON Inception.* TO 'jogomes-'@'%' ;" > hold.sql
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" > hold.sql
echo "FLUSH PRIVILEGES ;" > hold.sql

mariadb < hold.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld