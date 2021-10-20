#!/bin/bash

#Set variables
DATE=$(date +%Y-%m-%d-%H%M%S)
BACKUP_DIR="$HOME/backups"
SOURCE="/docker"

#Create archive
tar -cvzpf $BACKUP_DIR/backup-$DATE.tar.gz $SOURCE
