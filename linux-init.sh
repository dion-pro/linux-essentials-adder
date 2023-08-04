#!/bin/bash

# This script installs essential packages on a Debian-based system.
# NOTE: Run this script as root or with sudo.

# List of essential apps to install
essential_apps=(
    vim
    htop
    curl
    wget
    git
    unzip
    openssh-server
    tmux
    net-tools
    gnome-shell
    kde-plasma-desktop
    spotify
    neofetch
    obs-studio
)

# Function to check if a package is installed
is_package_installed() {
    dpkg -l "$1" &>/dev/null
    return $?
}

# Update package list
apt update

# Install essential apps that are not already installed
for app in "${essential_apps[@]}"; do
    if ! is_package_installed "$app"; then
        apt install -y "$app"
    else
        echo "Package $app is already installed. Skipping..."
    fi
done

# SPECIFICALLY GETS POWERSHELL FROM MICROSOFTS WEBSITE
# Save the public repository GPG keys
curl https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --yes --dearmor --output /usr/share/keyrings/microsoft.gpg

# Register the Microsoft Product feed
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/microsoft-debian-bullseye-prod bullseye main" > /etc/apt/sources.list.d/microsoft.list'

# Install PowerShell
apt update && apt install -y powershell

# Clean up after installation
apt autoremove -y
apt autoclean
