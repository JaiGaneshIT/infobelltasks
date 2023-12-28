#!/bin/bash

# Function to install packages on RPM-based systems
install_rpm() {
    sudo yum install -y $@
}

# Function to install packages on Debian-based systems
install_deb() {
    sudo apt-get update
    sudo apt-get install -y $@
}

# Check the Linux distribution
if [ -f /etc/redhat-release ]; then
    # RPM-based system
    echo "Detected RPM-based system"
    install_rpm openssh* net-tools docker*
elif [ -f /etc/lsb-release ]; then
    # Debian-based system
    echo "Detected Debian-based system"
    install_deb openssh* net-tools  docker-ce docker-ce-cli containerd.io docker-buildx-plugin
else
    echo "Unsupported Linux distribution"
    exit 1
fi

