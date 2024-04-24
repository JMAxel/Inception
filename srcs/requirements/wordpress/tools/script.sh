#!/bin/bash

#Create a directory needed to config nginx and wordpress
mkdir /var/www/
mkdir /var/www/html

cd /var/www/html

#Make sure the directory is empty
rm -rf *

#Download WP-CLI PHAR file
#-O = Tells curl to save the file with the same name as it has on the server
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#Make it executable
chmod +x wp-cli.phar

#Moves WP-CLI PHAR to a directory in system's PATH,
#which makes it executable anywhere, and changes the name to wp
mv wp-cli.phar /usr/local/bin/wp

#Download the latest version of WordPress
#--allow-root = Allows the command to be run as the root user
wp core download --allow-root

#Move already pre-configured wp-config to the right directory
mv /wp-config.wp /var/www/html/wp-config.php

#Installs wordpress and sets up basic configuration
#--url = Specific URL, --title = Site's title
#--admin_user = Username for site's administrator account
#--admin_password = Password for site's administrator account
#--admin_email = Email address for the administrator
#--skip-email = Prevents WP-CLI of sending an email with the login details
wp core install --url=$DOMAIN --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

#Creates a user account with the specified info
#--role = Gives user his role, giving him permission to publish and manage his posts
wp user create $USER $EMAIL --role=author --user_pass=$PWD --allow-root

#Install the Astra theme and activates it
#--activate = Tells WP-CLI to make it main theme for the site.
wp theme install astra --activate --allow-root

#Install redis-cache plugin
wp plugin install redis-cache --activate --allow-root

#Makes sure it's all updated
wp plugin update --all --allow-root