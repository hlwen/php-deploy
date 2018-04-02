#!/bin/bash

chown www-data:www-data /var/www/html -R
#mv /app/data/conf/database.php.back /app/data/conf/database.php
cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
#如果文件夹不存在，创建文件夹
if [ ! -d "/var/www/html/"$DIRNAME ]; then
  cd /var/www/html && git clone $WAIHUI && cd $WAIHUI

        if [ 0"$BRANCH" = "0" ]; then
           git checkout -b $BRANCH origin/$BRANCH && git pull
        else
            git reset --hard && git pull
        fi
        sh run.sh
else
  cd /var/www/html/$DIRNAME && git pull
fi
 
#cp /var/www/html/$DIRNAME/.env.production /var/www/html/$DIRNAME/.evn
cp /var/www/html/$DIRNAME/$DIRNAME.conf /etc/apache2/sites-available/
cp /var/www/html/$DIRNAME/$DIRNAME.conf /etc/apache2/sites-enabled/
cp /var/www/html/$DIRNAME/$DIRNAME.conf /etc/apache2/conf-enabled/

#chmod –R 777 /var/www/html/$DIRNAME/storage/*
#chmod –R 777 /var/www/html/$DIRNAME/public/*



#sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

#source /etc/apache2/envvars
#tail -F /var/log/apache2/* &

#exec /etc/init.d/apache2 reload
#exec /etc/init.d/apache2 -D FOREGROUND
exec apache2-foreground