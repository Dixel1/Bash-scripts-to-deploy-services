#!/bin/bash

# Description: Mumble deployment
# Autor: Dixel - https://github.com/Dixel1
# Version: v0.6b

# Update system packages
sudo apt-get update -y

# Install necessary packages
sudo apt-get install mumble-server -y

# Configure Mumble server
sudo dpkg-reconfigure mumble-server

# Start Mumble server
sudo systemctl start mumble-server

# Enable Mumble server to start at boot
sudo systemctl enable mumble-server

echo "Mumble server has been installed successfully!"
