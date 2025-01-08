#!/bin/bash

#start mariadb
mysql_install_db

/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$MARIA_DB" ]
then
	echo "Database exists"
else

mysql_secure_installation << _EOF_

Y
root4life
root4life
Y
n
Y
Y
_EOF_

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIA_ROOTPASS'; FLUSH PRIVILEGES" | mysql -uroot

echo "CREATE DATABASE IF NOT EXISTS $MARIA_DB; GRANT ALL ON $MARIA_DB.* TO '$MARIA_USER'@'%' IDENTIFIED BY '$MARIA_PASS'; FLUSH PRIVILEGES" | mysql -u root

mysql -uroot -p%MARIA_ROOTPASS $MARIA_DB < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"