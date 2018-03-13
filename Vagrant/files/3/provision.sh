#!/bin/bash
echo "Starting provision..."
sudo apt-get update
sudo apt-get install -y zip unzip python-software-properties software-properties-common curl git

# MySQL Installation
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password cloud"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password cloud"
sudo apt-get install -y mysql-server

# Creating the Database
mysql -u root -pcloud -e "CREATE DATABASE cloud;"
mysql -u root -pcloud -e "CREATE USER 'root'@'%' IDENTIFIED BY 'cloud';"
mysql -u root -pcloud -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';"
mysql -u root -pcloud -e "FLUSH PRIVILEGES;"

# Adding PHP Repository
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

# PHP Installation
sudo apt-get install php7.1 php7.1-xml php7.1-mbstring php7.1-mysql php7.1-json php7.1-curl php7.1-cli php7.1-common php7.1-mcrypt php7.1-gd libapache2-mod-php7.1 php7.1-zip

# Composer Installation
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Nginx Installations
sudo apt-get install -y nginx