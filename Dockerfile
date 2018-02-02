FROM php:7.0-apache

RUN apt-get update && apt-get -y install git vim

ADD . /app