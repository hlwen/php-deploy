FROM php:5.6-apache

RUN apt-get update && apt-get -y install git vim

RUN curl -fsSL 'https://xcache.lighttpd.net/pub/Releases/3.2.0/xcache-3.2.0.tar.gz' -o xcache.tar.gz \
    && mkdir -p xcache \
    && tar -xf xcache.tar.gz -C xcache --strip-components=1 \
    && rm xcache.tar.gz \
    && ( \
        cd xcache \
        && phpize \
        && ./configure --enable-xcache \
        && make -j$(nproc) \
        && make install \
    ) \
    && rm -r xcache \
    && docker-php-ext-enable xcache

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#
#RUN composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

ENV ALLOW_OVERRIDE **False**

COPY run.sh /

RUN chmod 755 /*.sh

ADD . /app

CMD ["/run.sh"]