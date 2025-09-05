#!/bin/bash
set -euo pipefail

LOG_DIR="$HOME/.local/share/rclone"
LOG_FILE="$LOG_DIR/bisync.log"

mkdir -p "$LOG_DIR"

# Run bisync
/usr/bin/rclone bisync "$HOME/Pictures" "onedrive:Pictures" \
    --create-empty-src-dirs \
    --verbose \
    --log-file="$LOG_FILE"


/usr/bin/rclone bisync "$HOME/Documents/conart" "onedrive:Documents/conart" \
    --create-empty-src-dirs \
    --verbose \
    --log-file="$LOG_FILE"
