#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: tiff2png.sh
# Description: Convert tiff to png
# Date: Oct 2024

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null
then
    echo "Error: ImageMagick is not installed."
    exit 1
fi

# Check if there are any .tif files
if [ -z "$(ls *.tif 2> /dev/null)" ]
then
    echo "Error: No .tif files found in the current directory."
    exit 1
fi

# Convert .tif files to .png
for f in *.tif; 
do  
    echo "Converting $f"; 
    if ! convert "$f" "$(basename "$f" .tif).png" 
    then
        echo "Error: Failed to convert."
        exit 1
    fi
done

echo "Conversion completed successfully."

