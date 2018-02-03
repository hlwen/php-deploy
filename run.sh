#!/bin/bash
chown www-data:www-data /app -R

#mv /app/data/conf/database.php.back /app/data/conf/database.php
#如果文件夹不存在，创建文件夹
if [ ! -d "/app/waihui" ]; then
  cd /app && git clone $WAIHUI
else
  cd /app/waihui && git pulll
fi
 
cp /app/waihui/.env.production /app/waihui/.evn
cp /app/waihui/waihui.conf /etc/apache2/sites-available/
cp /app/waihui/waihui.conf /etc/apache2/sites-enabled/ 

#if [ "$ALLOW_OVERRIDE" = "**False**" ]; then
#    unset ALLOW_OVERRIDE
#else
#    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
#    a2enmod rewrite
#fi
#source /etc/apache2/envvars
#tail -F /var/log/apache2/* &
exec /etc/init.d/apache2 restart