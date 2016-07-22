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
mkdir -p /var/www/baikal/Specific
touch /var/www/baikal/Specific/ENABLE_INSTALL
fi

cp -r Baikal-0.4.5/. baikal/.
rm -rf Baikal-0.4.5/
cd /var/www/baikal
composer install
chown -R www-data:www-data /var/www/baikal
fi

