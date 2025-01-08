#!/bin/sh

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

wget https://wordpress.org/latest.tar.gz
tar xfz latest.tar.gz
mv wordpress/* .
rm -rf latest.tar.gz
rm -rf wordpress

sed -i "s/username/$MARIA_USER/g" wp-config-sample-php
sed -i "s/password/$MARIA_PASS/g" wp-config-sample-php
sed -i "s/hostname/$MARIA_HOST/g" wp-config-sample-php
sed -i "s/database/$MARIA_DB/g" wp-config-sample-php
cp wp-config-sample.php wp-config.php

/usr/sbin/php-fpm7.3 -F