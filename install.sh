#!/bin/sh
apk --no-cache add openssh php curl php7-curl php7-cli php7-fpm php7-json php7-phar php7-openssl php7-iconv php7-mbstring
PHP_FPM_USER="www-data"
PHP_FPM_GROUP="www-data"
PHP_FPM_LISTEN_MODE="0660"
sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.conf
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.conf
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.conf
adduser -D -g 'www-data' www-data
mkdir /www/
chown -R www-data:www-data /www/
cd /www/
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
