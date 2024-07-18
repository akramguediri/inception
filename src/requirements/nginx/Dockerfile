FROM debian:bullseye

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
	openssl req -nodes -newkey rsa:4096 -x509 -sha256 -days 365 \
	-out /etc/nginx/ssl/aguediri.crt \
	-keyout /etc/nginx/ssl/aguediri.key \
	-subj "/C=DE/ST=Baden-Wuerttemberg/L=Heilbronn/O=42 Heilbronn/OU=aguediri/CN=aguediri/"

COPY conf/default /etc/nginx/sites-available/default

EXPOSE 443
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key\
#     -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=DE"
CMD ["nginx", "-g", "daemon off;"]
