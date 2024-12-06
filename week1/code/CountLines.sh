#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: CountLines.sh
# Description: Count lines in a file
# Date: Oct 2024


# Check if a filename was provided
if [ -z "$1" ];
then
    echo "Error: No filename provided."
    echo "Usage: $0 filename"
    exit 1
fi

# Check if the file exists and is readable
if [ ! -f "$1" ]; then
    echo "Error: File '$1' not found."
    exit 1
elif [ ! -r "$1" ]; then
    echo "Error: File '$1' is not readable."
    exit 1
fi

# Count the number of lines in the file
NumLines=$(wc -l < "$1")
if [ "$NumLines" -eq 0 ]; then
    echo "The file '$1' is empty."
else
    echo "The file '$1' has $NumLines line(s)."
fi

echo "Done"
