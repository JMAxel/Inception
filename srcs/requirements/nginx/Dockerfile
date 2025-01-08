FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install nginx -y
RUN apt-get install openssl -y

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/jogomes.key -out /etc/nginx/ssl/jogomes.crt -subj "/C=BR/L=RJ/O=42/OU=student/CN=jogomes-.42.fr"

COPY ./tools/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]