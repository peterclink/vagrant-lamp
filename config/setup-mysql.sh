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

# install mysql and give password to installer
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $PASSWORD"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $PASSWORD"
sudo apt-get -y install mysql-client mysql-server

# Allow root access from any host
sudo sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" ${MYSQL_CONFIG_FILE}
sudo sed -e '/skip-external-locking/ s/^#*/#/' -i ${MYSQL_CONFIG_FILE}
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$PASSWORD' WITH GRANT OPTION" | sudo mysql -u root --password=$PASSWORD
echo "GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION" | sudo mysql -u root --password=$PASSWORD

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $PASSWORD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $PASSWORD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $PASSWORD"
# sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
# sudo apt-get -y install phpmyadmin

sudo service mysql restart