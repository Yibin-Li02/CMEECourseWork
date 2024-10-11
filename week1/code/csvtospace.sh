#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: csvtospace.sh
# Description: Converts all CSV files in a directory to space-separated values files
# Date: Oct 2024

# Set the target directory (replace with your intended path)
target_dir=~/Documents/CMEECourseWork-Yibin.Li/week1/data

# Set the output directory for results
result_dir=~/Documents/CMEECourseWork-Yibin.Li/week1/results

# Check if the target directory exists
if [ ! -d "$target_dir" ]; 
then
    echo "Error: Directory $target_dir does not exist."
    exit 1
fi

# Check if the result directory exists
if [ ! -d "$result_dir" ]; 
then
    echo "Error: Directory $result_dir does not exist."
    exit 1
fi

# Change to the target directory
cd "$target_dir" || { echo "Error: Unable to change to directory $target_dir."; exit 1; }

# Check if there are any .csv files in the directory
if ls *.csv 1> /dev/null 2>&1; 
then
    echo "CSV files found. Processing..."
else
    echo "No CSV files found in the directory."
    exit 1
fi

# Loop through all .csv files and convert them
for input_file in *.csv; 
do
# Create the output file name by replacing ".csv" with "-output.ssv"
    output_file="$result_dir/${input_file%.csv}-output.ssv"
    
    echo "Converting $input_file to $output_file..."
    tr "," " " < "$input_file" > "$output_file"
    echo "$input_file converted successfully."
done

echo "All CSV files processed successfully."
