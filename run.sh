#!/bin/bash

chown www-data:www-data /var/www/html -R
#mv /app/data/conf/database.php.back /app/data/conf/database.php
#如果文件夹不存在，创建文件夹
if [ ! -d "/var/www/html/waihui" ]; then
  cd /var/www/html && git clone $WAIHUI && cd waihui && git pull && composer install
else
  cd /var/www/html/waihui && git pull && cd waihui && git pull && composer install
fi
 
cp /var/www/html/waihui/.env.production /var/www/html/waihui/.evn
cp /var/www/html/waihui/waihui.conf /etc/apache2/sites-available/
cp /var/www/html/waihui/waihui.conf /etc/apache2/sites-enabled/ 
cp /var/www/html/waihui/waihui.conf /etc/apache2/conf-enabled/ 

chmod –R 777 /var/www/html/waihui/storage/* 
chmod –R 777 /var/www/html/waihui/public/* 

cd /etc/apache2/mods-enabled
ln -s ../mods-avaiable/rewrite.load  rewrite.load


sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

#source /etc/apache2/envvars
#tail -F /var/log/apache2/* &

#exec /etc/init.d/apache2 reload
#exec /etc/init.d/apache2 -D FOREGROUND
exec apache2-foreground