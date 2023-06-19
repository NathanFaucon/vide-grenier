FROM php:7.4-apache AS base

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y git libzip-dev unzip curl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install pdo_mysql

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

WORKDIR /var/www/html

RUN git clone -b matthias https://github.com/NathanFaucon/vide-grenier .

RUN npm install

RUN composer install

RUN npm run build

# Configurez Apache - Remplacez "my_site.conf" par le nom de votre fichier de configuration Apache.
COPY ./httpd.conf /etc/apache2/sites-available
RUN a2ensite httpd.conf && a2dissite 000-default.conf
RUN a2enmod rewrite
RUN service apache2 restart

COPY ./sql/import.sql /docker-entrypoint-initdb.d/

EXPOSE 80
