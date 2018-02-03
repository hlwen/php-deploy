FROM php:7.1-apache

RUN apt-get update && apt-get -y install git vim

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf 

COPY run.sh /

ADD . /app

CMD ["/run.sh"]