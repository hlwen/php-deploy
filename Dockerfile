FROM 1and1internet/ubuntu-16-apache-php-7.1
MAINTAINER helianwen@hotmail.com
ARG DEBIAN_FRONTEND=noninteractive
ADD . /app

RUN apt-get update && apt-get upgrade && apt-get install git 

EXPOSE 80
WORKDIR /app

ENTRYPOINT ["sh","/app/run.sh"]