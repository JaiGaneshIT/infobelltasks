#!/bin/sh

# Define the list of packages to check and install
packages="openssh* net-tools docker*"

# Function to check if a package is installed on CentOS 7
check_centos() {
    for package in $packages; do
        if ! rpm -q $package > /dev/null 2>&1; then
            echo "Package '$package' is not installed."
            printf "Do you want to install it? (yes/no): "
            read answer
            if [ "$answer" = "y" ]; then
                sudo yum install $package
            else
                echo "Skipping installation of '$package'."
            fi
        else
            echo "Package '$package' is already installed."
        fi
    done
}

# Function to check if a package is installed on Ubuntu
check_ubuntu() {
    for package in $packages; do
        if ! dpkg -l $package > /dev/null 2>&1; then
            echo "Package '$package' is not installed."
            printf "Do you want to install it? (yes/no): "
            read answer
            if [ "$answer" = "y" ]; then
                sudo apt-get install $package
            else
                echo "Skipping installation of '$package'."
            fi
        else
            echo "Package '$package' is already installed."
        fi
    done
}

# Detect the Linux distribution and call the appropriate function
if [ -f "/etc/redhat-release" ]; then
    echo "Detected CentOS 7"
    check_centos
elif [ -f "/etc/lsb-release" ]; then
    echo "Detected Ubuntu"
    check_ubuntu
else
    echo "Unsupported Linux distribution."
fi

