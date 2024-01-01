#!/bin/bash

#prompt for the username

read -p " Enter the username: " answer

# Specify the username to collect history for
#username="jai"

# Define the path to the user's home directory
user_home=$(eval echo ~$username)

# Check if the user's home directory exists
if [ ! -d "$user_home" ]; then
    echo "User $username does not have a home directory."
    exit 1
fi

# Define the path to the user's bash history file
history_file="$user_home/.bash_history"

# Check if the history file exists
if [ ! -f "$history_file" ]; then
    echo "No bash history file found for user $username."
    exit 1
fi

# Copy the user's bash history file to a specified destination
destination_dir="/home"
destination_file="$destination_dir/bash_history_$username_$(date +'%Y%m%d%H%M%S').txt"

cp "$history_file" "$destination_file"

echo "Terminal history for user $username has been copied to $destination_file."

#initate the crontab -e 

#0 8 * * * /home/log.sh

