#!/bin/bash

# Define the threshold for disk usage (80%)
THRESHOLD=80

# Define the recipient email address
EMAIL="luthfanaul@gmail.com"

# Get the current disk usage of the root (/) filesystem
USAGE=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

# Check if disk usage exceeds the threshold
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    # Send an email alert
    echo "Subject: Disk Usage Alert - $(hostname)
    
    The disk usage on the root filesystem has exceeded ${THRESHOLD}%.
    Current usage: ${USAGE}%" | mail -s "Disk Usage Alert on $(hostname)" "$EMAIL"

    # Log the event (optional)
    echo "$(date): Disk usage on / is ${USAGE}% - Alert sent to $EMAIL" | sudo tee -a /var/log/disk_usage_alert.log
fi
