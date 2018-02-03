#!/bin/bash

chown www-data:www-data /var/www/html -R
#mv /app/data/conf/database.php.back /app/data/conf/database.php
#如果文件夹不存在，创建文件夹
if [ ! -d "/var/www/html/waihui" ]; then
  cd /var/www/html && git clone $WAIHUI && cd waihui && git pull
else
  cd /var/www/html/waihui && git branch --set-upstream-to=origin/ master && cd waihui && git pull
fi
 
cp /var/www/html/waihui/.env.production /var/www/html/waihui/.evn
cp /var/www/html/waihui/waihui.conf /etc/apache2/sites-available/
cp /var/www/html/waihui/waihui.conf /etc/apache2/sites-enabled/ 


if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
    unset ALLOW_OVERRIDE
else
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
    a2enmod rewrite
fi
#source /etc/apache2/envvars
#tail -F /var/log/apache2/* &

#exec /etc/init.d/apache2 reload
#exec /etc/init.d/apache2 -D FOREGROUND
exec apache2-foreground