FROM php:7.0-apache

RUN apt-get update && apt-get -y install git vim 

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pdo_mysql mysqli \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf 

ENV ALLOW_OVERRIDE **False**

COPY /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
COPY run.sh /
RUN chmod 755 /*.sh

ADD . /app

CMD ["/run.sh"]