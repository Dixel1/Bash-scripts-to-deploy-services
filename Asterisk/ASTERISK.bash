#!/bin/bash

# Description: Asterisk deployment
# Autor: Dixel - https://github.com/Dixel1
# Version: v0.6b

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y

# Install necessary packages
echo "Installing necessary packages..."
sudo apt-get install -y build-essential wget libssl-dev libncurses5-dev libnewt-dev libxml2-dev linux-headers-$(uname -r) libsqlite3-dev uuid-dev git subversion

# Download and extract the Asterisk source code
echo "Downloading and extracting the Asterisk source code..."
cd /usr/src/
sudo wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16-current.tar.gz
sudo tar xvf asterisk-16-current.tar.gz
cd asterisk-16*/

# Download the mp3 decoder library
echo "Downloading the mp3 decoder library..."
sudo contrib/scripts/get_mp3_source.sh

# Install the Asterisk dependencies
echo "Installing the Asterisk dependencies..."
sudo contrib/scripts/install_prereq install

# Configure and compile Asterisk
echo "Configuring and compiling Asterisk..."
sudo ./configure --with-pjproject-bundled
sudo make menuselect.makeopts
sudo menuselect/menuselect --enable format_mp3 --enable app_macro menuselect.makeopts
sudo make
sudo make install
sudo make config
sudo ldconfig

# Start Asterisk
echo "Starting Asterisk..."
sudo systemctl start asterisk

echo "Asterisk has been installed successfully!"
