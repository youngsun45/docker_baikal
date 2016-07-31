# set base os
FROM phusion/baseimage:0.9.19

MAINTAINER youngsun45 <youngsun45@mozilla.com>

# Set environment variables for my_init, terminal and apache
ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root
ENV COMPOSER_HOME $HOME/.composer
ENV TERM xterm
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

CMD ["/sbin/my_init"]

# add local files
ADD src/ /root/

# expose port(s)
EXPOSE 80

# startup files
RUN mkdir -p /etc/service/apache && \
mv /root/apache.sh /etc/service/apache/run && \
mv /root/firstrun.sh /etc/my_init.d/firstrun.sh && \
chmod +x /etc/service/apache/run && \
chmod +x /etc/my_init.d/firstrun.sh && \

# update apt and get dependencies etc..
apt-get update && \
apt-get install -y wget apache2 php7.0 libapache2-mod-php7.0 php7.0-sqlite \
                   php7.0-xml php7.0-mbstring zip phpmyadmin && \

# Enable apache mods.
a2enmod php7.0 && \
a2enmod rewrite && \

# Update the PHP.ini file, enable <? ?> tags and quieten logging.
sed -i "s/short_open_tag = Off/short_open_tag = On/" /etc/php/7.0/apache2/php.ini && \
sed -i "s/error_reporting = .*$/error_reporting = E_ERROR | E_WARNING | E_PARSE/" /etc/php/7.0/apache2/php.ini && \
mv /root/apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# Composer
RUN mkdir -p $COMPOSER_HOME && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    chmod 755 /usr/local/bin/composer
