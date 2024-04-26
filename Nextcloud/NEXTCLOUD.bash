#!/bin/bash

# Description: Nextcloud deployment
# Autor: Dixel - https://github.com/Dixel1
# Version: v0.7b

# Update the system packages
sudo apt-get update -y

# Install the necessary packages
sudo apt-get install apache2 php libapache2-mod-php php-gd php-mysql php-curl php-mbstring php-xml php-zip php-intl php-imagick php-bcmath php-gmp mariadb-server mariadb-client python3-pymysql unzip -y

# Download Nextcloud
wget https://download.nextcloud.com/server/releases/latest.zip -O nextcloud.zip

# Unzip the zip file
unzip nextcloud.zip

# Copy the necessary files to the /var/www/html directory
sudo mkdir /var/www/html/nextcloud
sudo cp -r nextcloud/. /var/www/html/nextcloud/

# Create a MySQL user for Nextcloud
sudo mysql -u root -e "CREATE DATABASE nextcloud;"
sudo mysql -u root -e "CREATE USER 'nextcloud_user'@'localhost' IDENTIFIED BY 'nextcloud_password';"
sudo mysql -u root -e "GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud_user'@'localhost';"
sudo mysql -u root -e "FLUSH PRIVILEGES;"

# Configure Apache for Nextcloud
sudo cp /var/www/html/nextcloud/config/config.sample.php /var/www/html/nextcloud/config/config.php
sudo chown -R www-data:www-data /var/www/html/nextcloud/

# Enable required modules in Apache
sudo a2enmod rewrite
sudo service apache2 restart

# Redirect requests to Nextcloud
echo "Redirect / https://yourdomain.com/nextcloud/" | sudo tee -a /etc/apache2/conf-available/redirect.conf
sudo a2enconf redirect
sudo service apache2 restart
echo "Nextcloud has been installed successfully!"
