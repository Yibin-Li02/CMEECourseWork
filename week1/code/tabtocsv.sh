#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas

# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2024

# Check if exactly one argument is provided
if [ $# -ne 1 ];
then
    echo "Error: Provide only one file."
    exit 1
fi

input_file="$1"

# Check if the file exists and ends with .txt
if [ ! -f "$1" ]; 
then 
    echo "Error: File not found."
    exit 1
fi

if [[ "$1" != *.txt ]]; 
then 
    echo "Error: Must be a .txt file."
    exit 1
fi

# Check if the output file already exists
output_file="${1%.*}.csv"
if [ -f "$output_file" ]; 
then
    echo "Error: Output file '$output_file' already exists."
    exit 1
fi

# Convert tabs to commas and save as .csv
echo "Converting $1 to CSV format..."
cat "$1" | tr "\t" "," > "${1%.*}.csv"
echo "Done!"




