FROM debian:bullseye

RUN apt-get update
RUN apt-get install -y php php7.3-fpm php-gd wget php-mysqli

RUN mkdir -p /var/www/html /run/php && chown -R www-data:www-data /var/www/html /run/php && chmod -R 777 /var/www/html

COPY setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar &&  mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html

CMD ["php-fpm8.2", "-F"]