#!/bin/bash

# Set up base Ubuntu Development System
# General Forensics
# 2014-08-18
#
# Usage:
#    Run by Packer

### Install AMP
# Install Apache
apt-get -y install apache2

# Install MySQL 5.6 - root password is set to root
echo mysql-server mysql-server/root_password password root | debconf-set-selections
echo mysql-server mysql-server/root_password_again password root | debconf-set-selections
apt-get -y install mysql-server-5.6

# Install PHP5
apt-get -y install php5 libapache2-mod-php5 php5-mcrypt php5-mysql php5-xdebug

# Enable Xdebug
XDEBUG_FILE="/etc/php5/mods-available/xdebug.ini"
cat <<EOF > $XDEBUG_FILE
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_mode=req
xdebug.remote_host=127.0.0.1
xdebug.remote_port=9000
EOF

# Restart Apache
apachectl restart

# Install PHPInfo
echo "<?php phpinfo(); ?>" | tee /var/www/html/phpinfo.php

# Java 7 OpenJDK
apt-get -y install openjdk-7-jdk

