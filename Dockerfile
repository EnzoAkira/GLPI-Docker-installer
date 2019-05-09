FROM php:7.2.18-apache

COPY ./glpi /var/www/html

COPY ./fusioninventory /var/www/html/plugins/fusioninventory

COPY ./config_db.php /var/www/html/config

RUN chown -R www-data:www-data /var/www/html && chmod -R ug+rw /var/www/html/

RUN apt-get update \
&& apt-get install -y \
supervisor \
cron \
iputils-ping \
libfreetype6-dev \
libxml2-dev \
libjpeg62-turbo-dev \
libpng-dev \
libjpeg-dev \
&& docker-php-ext-install -j$(nproc) xmlrpc opcache pdo_mysql mysqli mbstring \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install -j$(nproc) gd \
&& rm -rf /var/lib/apt/lists/*

RUN echo "*/5 * * * * /usr/local/bin/php /var/www/html/front/cron.php &>/dev/null" | crontab -

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www/html 

CMD /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
