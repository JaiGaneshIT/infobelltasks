#!/bin/bash

# Function to check if a package is installed on Debian-based systems
is_package_installed_debian() {
    dpkg -s "$1" &> /dev/null
}

# Function to install a package on Debian-based systems
install_package_debian() {
    sudo apt-get install -y "$1"
}

# Function to check if a package is installed on Red Hat-based systems
is_package_installed_rhel() {
    rpm -q "$1" &> /dev/null
}

# Function to install a package on Red Hat-based systems
install_package_rhel() {
    sudo yum install -y "$1"
    # For dnf (Fedora, RHEL 8+), replace the above line with:
    # sudo dnf install -y "$1"
}

# Function to prompt the user for confirmation
prompt_for_installation() {
    read -p "Do you want to install $1? (y/n): " choice
    case "$choice" in
        y|Y )
            return 0 ;; # User chose to install
        * )
            return 1 ;; # User chose not to install
    esac
}

PACKAGES=("openssh*" "net-tools" "docker*")

for package in "${PACKAGES[@]}"; do
    if is_package_installed_debian "$package" || is_package_installed_rhel "$package"; then
        echo "$package is already installed."
    else
        echo "$package is not installed."
        if prompt_for_installation "$package"; then
            echo "Installing $package..."
            if [ -f /etc/debian_version ]; then
                install_package_debian "$package"
            elif [ -f /etc/redhat-release ]; then
                install_package_rhel "$package"
            else
                echo "Unsupported distribution."
                exit 1
            fi
        else
            echo "Skipping installation of $package."
        fi
    fi
done

