#!/bin/bash

# Description: Proxmox deployment
# Autor: Dixel - https://github.com/Dixel1
# Version: v0.6b

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y

# Install necessary packages
echo "Installing necessary packages..."
sudo apt-get install -y curl wget gnupg

# Add Proxmox repository
echo "Adding Proxmox repository..."
echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" | sudo tee /etc/apt/sources.list.d/pve-install-repo.list

# Add Proxmox repository key
echo "Adding Proxmox repository key..."
wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O proxmox-ve-release-6.x.gpg
sudo apt-key add proxmox-ve-release-6.x.gpg

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install Proxmox
echo "Installing Proxmox..."
sudo apt-get install -y proxmox-ve postfix open-iscsi

# Remove the enterprise repository to prevent error messages
echo "Removing the enterprise repository..."
sudo rm /etc/apt/sources.list.d/pve-enterprise.list

# Update all packages
echo "Updating all packages..."
sudo apt-get dist-upgrade -y

# Reboot the system
echo "Rebooting the system..."
sudo reboot

echo "Proxmox has been installed successfully!"
