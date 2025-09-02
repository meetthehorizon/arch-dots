#!/bin/bash

# Requires ImageMagick (identify)
# Install on Arch: sudo pacman -S imagemagick

# Current directory
DIR="$(pwd)"

# Loop over image files
shopt -s nullglob
for file in "$DIR"/*.{jpg,jpeg,png,gif,bmp,tiff}; do
    # Skip directories
    [ -f "$file" ] || continue

    # Get resolution: WIDTHxHEIGHT
    res=$(identify -format "%wx%h" "$file" 2>/dev/null)

    # Skip if not an image
    [ -n "$res" ] || continue

    # Create folder if it doesn't exist
    mkdir -p "$DIR/$res"

    # Copy the file
    mv "$file" "$DIR/$res/"
done

echo "Done! Pictures copied into folders by resolution."

