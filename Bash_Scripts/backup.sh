#!/bin/bash

# Check if a directory path is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

# Define the directory to backup
DIR_TO_BACKUP=$1

# Check if the provided argument is a valid directory
if [ ! -d "$DIR_TO_BACKUP" ]; then
    echo "Error: Directory $DIR_TO_BACKUP does not exist."
    exit 1
fi

# Define the backup destination directory
BACKUP_DIR="/var/backups"

# Ensure the backup directory exists
if [ ! -d "$BACKUP_DIR" ]; then
    sudo mkdir -p "$BACKUP_DIR"
fi

# Create a timestamp for the backup filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Define the backup filename
BACKUP_FILENAME="backup_${TIMESTAMP}.tar.gz"

# Create the tarball and compress it
tar -czf "${BACKUP_DIR}/${BACKUP_FILENAME}" "$DIR_TO_BACKUP"

# Check if the tar command was successful
if [ $? -eq 0 ]; then
    # Log the successful backup operation
    echo "$(date +"%Y-%m-%d %H:%M:%S"): Backup of $DIR_TO_BACKUP was successful. Saved as $BACKUP_FILENAME." | sudo tee -a /var/log/backup.log
else
    # Log the failed backup operation
    echo "$(date +"%Y-%m-%d %H:%M:%S"): Backup of $DIR_TO_BACKUP failed." | sudo tee -a /var/log/backup.log
    exit 1
fi
