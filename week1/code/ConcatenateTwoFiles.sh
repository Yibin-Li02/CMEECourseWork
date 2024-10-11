#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenate the contents of two files
# Date: Oct 2024

# Check if exactly two arguments are provided
if [ $# -ne 3 ]; 
then
    echo "Error: Provide three files."
    exit 1
fi

# Assign input arguments to variables
input_file1="$1"
input_file2="$2"
output_file="$3"

# Check if both files exist
if [ ! -f "$input_file1" ]; 
then
    echo "Error: File '$input_file1' does not exist."
    exit 1
fi

if [ ! -f "$input_file2" ]; 
then
    echo "Error: File '$input_file2' does not exist."
    exit 1
fi

# Check if the output file already exists
if [ -f "$output_file" ]; 
then
    echo "Error: Output file '$output_file' already exists."
    exit 1
fi

# Concatenate the contents of the two input files into the output file
cat "$input_file1" > "$output_file"
cat "$input_file2" >> "$output_file"
echo "The contents of the merged file ($output_file) are"
cat "$output_file"

echo "Done!"