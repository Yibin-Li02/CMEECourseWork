#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenate the contents of two files
# Date: Oct 2024

# Check if exactly three arguments are provided
if [ $# -ne 3 ]; then
    echo "Error: Please provide exactly two input files and one output file."
    echo "Usage: $0 input_file1 input_file2 output_file"
    exit 1
fi

# Assign input arguments to variables
input_file1="$1"
input_file2="$2"
output_file="$3"

# Check if both input files exist
for file in "$input_file1" "$input_file2"; do
    if [ ! -f "$file" ]; then
        echo "Error: Input file '$file' does not exist."
        exit 1
    fi
done

# Check if the output file already exists
if [ -f "$output_file" ]; then
    echo "Error: Output file '$output_file' already exists. Please choose a different filename or delete the existing file."
    exit 1
fi

# Concatenate the contents of the two input files into the output file
cat "$input_file1" "$input_file2" > "$output_file"
echo "The contents of the merged file ($output_file) are:"
cat "$output_file"

echo "Done!"
