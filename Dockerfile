FROM php:7.1-apache

RUN apt-get update && apt-get -y install git vim
COPY run.sh /
ADD . /app

ENTRYPOINT ["sh","/run.sh"]