FROM debian:bullseye

RUN apt-get update -y
RUN apt-get install nginx -y
RUN apt-get install openssl -y

COPY ./tools/script.sh /

CMD [ "/script.sh" ]