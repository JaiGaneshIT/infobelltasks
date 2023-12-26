#!/bin/bash

#
echo "Welcome to the Application Installer Script!"

# Defining a list of applications to install
apps=("openssh-server" "net-tools" "docker-engine")

# Loop through the applications and install them
for app in "${apps[@]}"; do
    echo "Installing $app..."
    sudo yum install $app -y
    echo "Command to install $app goes here"
done

echo "Installation complete."
