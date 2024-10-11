#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: csvtospace.sh
# Description: converts csv file to a space separated values file
# Date: Oct 2024

# Check if the file was provided
if [ $# -eq 0 ]; 
then
    echo "No file provided. Please provide a CSV file."
    exit 1
fi

# Check if exactly one argument is provided

if [ $# -ne 1 ];
then
    echo "Error: Provide only one file."
    exit 1
fi

input_file="$1"

# Check if the file exists and ends with .csv
if [ ! -f "$1" ]; 
then 
    echo "Error: File not found."
    exit 1
fi

if [[ "$1" != *.csv ]]; 
then 
    echo "Error: Must be a .csv file."
    exit 1
fi

# Check if the output file already exists

output_file="${1%.*}_output.ssv"

if [ -f "$output_file" ]; 
then
    echo "Error: Output file '$output_file' already exists."
    exit 1
fi

# Convert commas to space and save as .ssv

echo "Converting $1 to SSV format..."
tr "," " " < "$1" > "${1%.*}_output.ssv"
echo "Done!"