FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install wget curl bash php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring redis php-redis -y
RUN rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN mkdir /run/php

COPY ./tools/script.sh ./
RUN chmod +x script.sh

EXPOSE 9000

CMD ["./script.sh"]