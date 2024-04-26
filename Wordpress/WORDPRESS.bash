#!/bin/bash

# Description: Wordpress deployment
# Autor: Dixel - https://github.com/Dixel1
# Version: v0.6b

# Update system packages
sudo apt-get update -y

# Install necessary packages
sudo apt-get install apache2 mysql-server php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

# Download the latest WordPress package
wget https://wordpress.org/latest.tar.gz

# Extract the WordPress package
tar xzvf latest.tar.gz

# Create the WordPress wp-config.php file
cp wordpress/wp-config-sample.php wordpress/wp-config.php

# Set the ownership and permissions
sudo chown -R www-data:www-data wordpress/
sudo find wordpress/ -type d -exec chmod 750 {} \;
sudo find wordpress/ -type f -exec chmod 640 {} \;

# Move the WordPress files to the web root directory
sudo cp -r wordpress/* /var/www/html/

# Create a new MySQL database for WordPress
sudo mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
sudo mysql -u root -e "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Enable the Apache rewrite module
sudo a2enmod rewrite

# Restart Apache
sudo systemctl restart apache2

echo "WordPress has been installed successfully!"
