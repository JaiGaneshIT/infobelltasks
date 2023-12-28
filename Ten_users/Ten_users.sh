#!/bin/bash

 # Function to create a user for RPM-based systems
create_rpm_user() {
  local username="$1"
  local password="$2"
  useradd -m -s /bin/bash "$username"
  echo "$username:$password" | chpasswd
}

# Function to create a user for Debian-based systems
create_debian_user() {
  local username="$1"
  local password="$2"
  useradd -m -s /bin/bash "$username"
  echo "$username:$password" | chpasswd
}

# Main script

# Check the Linux distribution and create user accordingly
if [ -f /etc/redhat-release ]; then
  echo "RPM-based system detected."
elif [ -f /etc/debian_version ]; then
  echo "Debian-based system detected."
else
  echo "Unsupported Linux distribution."
  exit 1
fi

# Loop to create users
while read -r line; do
  IFS=':' read -r -a user_info <<< "$line"
  username="${user_info[0]}"
  password="${user_info[1]}"

  # Check the Linux distribution and create user accordingly
  if [ -f /etc/redhat-release ]; then
    create_rpm_user "$username" "$password"
    echo "User created for RPM-based system:"
  elif [ -f /etc/debian_version ]; then
    create_debian_user "$username" "$password"
    echo "User created for Debian-based system:"
  fi

  echo "Username: $username"
 #echo "Password: $password"
  echo "-----------------------------"
done <<EOL

Yu_Ir_po:yvonne
BrKiOg:brain
NaWaPa:natalie
An_Al:anthony
Ch_Mi:christopher
Jo_Mu:joan
Je_Ha:jessica
Jo_Al:john
Ni_Ed_Re:nicholas
ka_Sh:karen
EOL
