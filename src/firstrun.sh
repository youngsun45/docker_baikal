#!/bin/bash
if [ -f "/var/www/baikal/html/index.php" ]; then
echo "using existing website"
chown -R www-data:www-data /var/log/apache2
else
echo "fetching Baikal files"
cd /var/www
wget https://github.com/fruux/Baikal/archive/0.4.5.tar.gz
tar xvf 0.4.5.tar.gz
rm 0.4.5.tar.gz

if [ -f "/var/www/baikal/Specific/db/db.sqlite" ]; then
rm -rf Baikal-0.4.5/Specific
else
  mkdir /var/www/baikal
fi

cp -r Baikal-0.4.5/. baikal/.
rm -rf Baikal-0.4.5/
cd /var/www/baikal
echo HOME: $HOME
echo COMPOSER_HOME: $COMPOSER_HOME
echo Using curl to get composer...
curl -s https://getcomposer.org/installer | php
mv composer.phar composer
./composer install
cd /var/www/baikal/Specific
touch ENABLE_INSTALL
chown -R www-data:www-data /var/www/baikal
fi

