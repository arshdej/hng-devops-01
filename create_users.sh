#!/bin/bash

# Log file location
LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to generate random password
generate_password() {
    echo "$(openssl rand -base64 12)"
}

# Create the secure directories if not existing
mkdir -p /var/secure
touch "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE"

# Read the file line by line
while IFS=";" read -r username groups; do
    username=$(echo "$username" | xargs)  # Remove whitespace
    groups=$(echo "$groups" | xargs)      # Remove whitespace
    
    if id "$username" &>/dev/null; then
        log_message "User $username already exists."
        continue
    fi
    
    # Create user and personal group
    useradd -m -s /bin/bash "$username"
    log_message "User $username created."
    
    # Set home directory permissions
    chmod 700 "/home/$username"
    chown "$username:$username" "/home/$username"
    log_message "Home directory for $username set with appropriate permissions."
    
    # Add user to additional groups
    IFS="," read -r -a group_array <<< "$groups"
    for group in "${group_array[@]}"; do
        group=$(echo "$group" | xargs)  # Remove whitespace
        if ! getent group "$group" &>/dev/null; then
            groupadd "$group"
            log_message "Group $group created."
        fi
        usermod -aG "$group" "$username"
        log_message "User $username added to group $group."
    done
    
    # Generate and set password
    password=$(generate_password)
    echo "$username:$password" | chpasswd
    log_message "Password for $username set."
    
    # Store password securely
    echo "$username:$password" >> "$PASSWORD_FILE"
    
done < "$1"

log_message "User creation script completed."
