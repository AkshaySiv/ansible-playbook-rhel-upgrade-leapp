#!/bin/bash

HOSTFILE="leapp_upgrade_playbook/hosts"
KEY="${HOME}/.ssh/id_rsa.pub"

# Check if host file exists
if [ ! -f "$HOSTFILE" ]; then
    echo "Host file $HOSTFILE not found!"
    exit 1
fi

# Loop through each line in the host file
while IFS= read -r HOST; do
    if [[ -z "$HOST" ]]; then
        continue  # Skip empty lines
    fi

    echo "Copying SSH key to $HOST"
    ssh-copy-id -i "$KEY" "$HOST"

    if [ $? -eq 0 ]; then
        echo "✅ Successfully copied key to $HOST"
    else
        echo "❌ Failed to copy key to $HOST"
    fi
done < "$HOSTFILE"
