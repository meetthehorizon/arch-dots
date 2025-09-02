#!/bin/bash

# Log file
LOGFILE="$HOME/rclone-sync.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "=== Rclone push started at $DATE ===" >> "$LOGFILE"

# Pictures
rclone sync "$HOME/Pictures" onedrive:Pictures --verbose --transfers=4 --checkers=8 >> "$LOGFILE" 2>&1

# Documents/conart
rclone sync "$HOME/Documents/conart" onedrive:Documents/conart --verbose --transfers=4 --checkers=8 >> "$LOGFILE" 2>&1

echo "=== Rclone push finished at $(date '+%Y-%m-%d %H:%M:%S') ===" >> "$LOGFILE"
echo "" >> "$LOGFILE"

