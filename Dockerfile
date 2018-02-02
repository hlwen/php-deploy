FROM 1and1internet/ubuntu-16-apache-php-7.1
MAINTAINER helianwen@hotmail.com
ARG DEBIAN_FRONTEND=noninteractive
ADD . /app

	
EXPOSE 80
WORKDIR /app

CMD ["/app/run.sh"]