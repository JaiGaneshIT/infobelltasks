#!/bin/bash

# Set the non-sudo username
USERNAME="jai"

# Set the list of remote nodes separated by space
NODES="hpccluster1 hpccluster2"

# Generate SSH key pair
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""

# Copy public key to remote nodes
for NODE in $NODES; do
    echo "Copying public key to $NODE"
    ssh-copy-id -i ~/.ssh/id_rsa.pub "$USERNAME@$NODE"
done

# Set correct permissions for SSH directory and files
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/id_rsa.pub

echo "Passwordless SSH setup complete for non-sudo user $USERNAME on all nodes."
