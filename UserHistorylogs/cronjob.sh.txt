#!/bin/bash

#set the path to the history file
jhistory="/home/history.logs"

# Use the history command to get the current Bash history
history > "$jhistory"

echo "Bash history has been saved to $jhistory"


#intiate the crobtab -e job in the workstation

0 8 * * * /home/history.sh

