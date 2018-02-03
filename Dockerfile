FROM php:7.0-apache

RUN apt-get update && apt-get -y install git vim 

RUN apt-get install -y python-software-properties 

RUN apt-get install -y software-properties-common

RUN add-apt-repository -y -u ppa:ondrej/php

RUN apt-get update 

RUN apt-get install php7.0-gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf 

ENV ALLOW_OVERRIDE **False**

COPY run.sh /
RUN chmod 755 /*.sh

ADD . /app

CMD ["/run.sh"]