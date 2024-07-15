FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y nginx openssl

COPY ./conf/default /etc/nginx/sites-available/default

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key\
    -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=DE"
CMD ["nginx", "-g", "daemon off;"]
