FROM debian:bullseye

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y php php7.4-fpm php-gd wget php-mysql

RUN mkdir -p /var/www/html /run/php && chown -R www-data:www-data /var/www/html /run/php && chmod -R 777 /var/www/html

COPY www.conf /etc/php/7.4/fpm/pool.d/
COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh
RUN chmod +x /etc/php/7.4/fpm/pool.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar &&  mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]