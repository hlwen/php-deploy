#!/bin/bash

chown www-data:www-data /var/www/html -R
#mv /app/data/conf/database.php.back /app/data/conf/database.php
cp /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
#如果文件夹不存在，创建文件夹
if [ ! -d "/var/www/html/"$DIRNAME ]; then
  cd /var/www/html && git clone $WAIHUI && cd $WAIHUI

        if [ $BRANCH ]; then
           git checkout -b $BRANCH origin/$BRANCH && git pull
           echo "checkout"$BRANCH
        else
           git reset --hard && git pull echo

          echo  "reset --hard"

        fi

else
  cd /var/www/html/$DIRNAME && git pull

  echo  "pull"
fi

sh run.sh
#cp /var/www/html/$DIRNAME/.env.production /var/www/html/$DIRNAME/.evn
cp /var/www/html/$DIRNAME/$DIRNAME.conf /etc/apache2/sites-available/
cp /var/www/html/$DIRNAME/$DIRNAME.conf /etc/apache2/sites-enabled/
cp /var/www/html/$DIRNAME/$DIRNAME.conf /etc/apache2/conf-enabled/



sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

#source /etc/apache2/envvars
#tail -F /var/log/apache2/* &

#exec /etc/init.d/apache2 reload
#exec /etc/init.d/apache2 -D FOREGROUND
exec apache2-foreground