#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: csvtospace.sh
# Description: Converts all CSV files in a directory to space-separated values files
# Date: Oct 2024


# Set the target and output directories (replace with your intended paths)
target_dir=~/Documents/CMEECourseWork-Yibin.Li/wseek1/data
result_dir=~/Documents/CMEECourseWork-Yibin.Li/week1/results

# Ensure target and result directories exist
[ ! -d "$target_dir" ] && { echo "Error: Target directory '$target_dir' does not exist."; exit 1; }
[ ! -d "$result_dir" ] && { echo "Creating result directory '$result_dir'..."; mkdir -p "$result_dir"; }

# Change to the target directory or exit on failure
cd "$target_dir" || { echo "Error: Unable to change to directory '$target_dir'."; exit 1; }

# Check for CSV files and process them
for input_file in *.csv; do
    [ -e "$input_file" ] || { echo "No CSV files found in the target directory."; exit 1; }
    output_file="$result_dir/${input_file%.csv}-output.ssv"
    
    # Confirm overwrite if the output file exists
    if [ -e "$output_file" ]; then
        echo "Warning: Output file '$output_file' already exists. Overwrite? (y/n)"
        read -r response
        if [ "$response" != "y" ]; then
            echo "Skipping $input_file."
            continue
        fi
    fi
    
    echo "Converting $input_file to $output_file..."
    if tr "," " " < "$input_file" > "$output_file"; then
        echo "$input_file converted successfully."
    else
        echo "Error: Failed to convert $input_file."
    fi
done

echo "All CSV files processed successfully."
