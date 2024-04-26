#!/bin/bash

#Create a self-signed SSL/TLS certificate and a private key using OpenSSL
#req = Used to generate a certificate signing request (CSR), or a self-signed certificate
#-x509 = Confirms self-signed certificate option
#-nodes = Makes OpenSSL not encrypt the private key
#-days = How many days that certificate should be valid
#-newkey = Specifies that a new private key should be generated
#rsa:2048 = Together with the last flag, confirms that a new RSA key with a length of 2048 bits have to be made
#-keyout = Decides where the private key should be stored
#-out = Decides where the certificate should be stored
#-subj = Specifies some info for that certificate, like country, location, organization, etc
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=BR/L=RJ/O=42/OU=student/CN=jogomes-.42.fr"

echo "
	server {
		listen 443 ssl;
		listen [::]:443 ssl;

		server_name www.$DOMAIN $DOMAIN

		ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
		ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;

		ssl_protocols TLSv1.3;

		index index.php;
		root /var/www/html;

		location ~ [^/]\\.php(/|$) {
			try_files $uri = 404;
			fastcgi_pass wordpress:9000;
			include fastcgi_params;
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
		}
	}" >> /etc/nginx/sites-available/default

nginx -g "daemon off;"