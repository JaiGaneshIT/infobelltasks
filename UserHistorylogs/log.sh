#!/bin/bash

# Prompt user for username
read -p "Enter the username: " username

# Set the log file paths for RHEL and Debian
rhel_log="/var/log/messages"
debian_log="/var/log/syslog"

# Check if the system is RHEL or Debian-based
if [ -f /etc/redhat-release ]; then
    # RHEL-based system
    user_history_log="/var/log/secure"
elif [ -f /etc/debian_version ]; then
    # Debian-based system
    user_history_log="/var/log/auth.log"
else
    echo "Unsupported operating system."
    exit 1
fi

# Check if the provided username exists
if id "$username" &>/dev/null; then
    # Collect and store user history logs
    echo "Collecting user history logs for $username..."

    # Use sudo to access log files
    sudo grep -i "$username" "$user_history_log" > /home/"$username"_history.log

    echo "User history logs for $username have been stored in $(pwd)/$username\_history.log"
else
    echo "User $username does not exist."
    exit 1
fi


