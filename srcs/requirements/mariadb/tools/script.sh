#!/bin/bash

#start mariadb
service mariadb start

#Create database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > hold.sql

#Create user
echo "CREATE USER IF NOT EXISTS '$USER'@'%' IDENTIFIED BY '$PWD' ;" > hold.sql

#Gives all privileges of some specified database to some user
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_NAME-'@'%' ;" > hold.sql

#Alter user
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '1234' ;" > hold.sql

#Used to clear mariadb cache, so all changes can take effect
echo "FLUSH PRIVILEGES ;" > hold.sql

#Send all commands before inside mariadb properly
mariadb < hold.sql

#Confirms that no mariadb is open and running
kill $(cat /var/run/mysqld/mysqld.pid)

#Starts MariaDB
mysqld