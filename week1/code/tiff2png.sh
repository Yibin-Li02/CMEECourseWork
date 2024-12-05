#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: tiff2png.sh
# Description: Convert tiff to png
# Date: Oct 2024

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it to proceed."
    exit 1
fi

# Check if there are any .tif files in the current directory
if ! ls *.tif 1> /dev/null 2>&1; then
    echo "Error: No .tif files found in the current directory."
    exit 1
fi

# Convert .tif files to .png
for f in *.tif; do  
    output_file="$(basename "$f" .tif).png"
    echo "Converting $f to $output_file..."
    if convert "$f" "$output_file"; then
        echo "$f converted successfully."
    else
        echo "Error: Failed to convert $f."
        exit 1
    fi
done

echo "All .tif files have been converted successfully."


