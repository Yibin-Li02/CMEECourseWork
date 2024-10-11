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
    echo "Error: Provide only one .txt file."
    exit 1
fi

input_file="$1"

# Check if the file exists and ends with .txt
if [ ! -f "$input_file" ]; 
then 
    echo "Error: File '$input_file' not found."
    exit 1
fi

if [[ "$input_file" != *.txt ]]; 
then 
    echo "Error: '$input_file' must be a .txt file."
    exit 1
fi

# Check if the output file already exists
output_file="${input_file%.*}.csv"
if [ -f "$output_file" ]; 
then
    echo "Error: Output file '$output_file' already exists."
    exit 1
fi

# Convert tabs to commas and save as .csv
echo "Converting $input_file to CSV format..."
tr '\t' ',' < "$input_file" > "$output_file"

echo "Done!"




