#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='root'
PROJECTFOLDER='/var/www'
MYSQL_CONFIG_FILE="/etc/mysql/my.cnf"

sudo add-apt-repository -y ppa:ondrej/php

# update / upgrade
sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get install language-pack-UTF-8

echo "Installing autoremove"
sudo apt-get -y autoremove

echo "Install Curl"
sudo apt-get install -y curl

# install apache 2.5 and php 5.6
# sudo apt-cache search php5.6
sudo apt-get install -y apache2
sudo apt-get install -y --force-yes php5.6-common php5.6-cli php5.6 libapache2-mod-php5.6 php-pear php5.6-mysql php-xdebug php5.6-curl php5.6-mbstring php5.6-mcrypt php5.6-gd

# php -i | grep 'php.ini'
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/5.6/apache2/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/5.6/apache2/php.ini

# setup hosts file
VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "${PROJECTFOLDER}"
    <Directory "${PROJECTFOLDER}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/000-default.conf

# enable mod_rewrite
sudo a2enmod rewrite

# restart apache
service apache2 restart
sudo rm -rf /var/www/html

# install git
sudo apt-get -y install git

# install Composer
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Creating example virtual host
sudo mkdir -p /var/www/example.com
sudo chown -R $USER:$USER /var/www/example.com
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/example.com.conf

# setup hosts file
EXAMPLEVHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerAdmin admin@example.com
    ServerName example.com
    ServerAlias www.example.com
    DocumentRoot /var/www/example.com
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
    <Directory "/var/www/example.com">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${EXAMPLEVHOST}" > /etc/apache2/sites-available/example.com.conf

sudo a2ensite example.com.conf
sudo service apache2 restart