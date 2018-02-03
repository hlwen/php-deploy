FROM 1and1internet/ubuntu-16-apache-php-7.0

RUN apt-get update && apt-get -y install git vim 


RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf 

ENV ALLOW_OVERRIDE **False**

COPY run.sh /
RUN chmod 755 /*.sh

ADD . /app

CMD ["/run.sh"]