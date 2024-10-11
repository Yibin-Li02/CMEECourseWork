#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: ConcatenateTwoFiles.sh
# Description: Concatenate the contents of two files
# Date: Oct 2024

# Check if exactly two arguments are provided
if [ $# -ne 3 ]; 
then
    echo "Error: Provide two input files and one output file."
    exit 1
fi

# Check if both files exist
if [ ! -f "$1" ]; 
then
    echo "Error: File '$1' does not exist."
    exit 1
fi

if [ ! -f "$2" ]; 
then
    echo "Error: File '$2' does not exist."
    exit 1
fi

# Check if the output file already exists
if [ -f "$3" ]; 
then
    echo "Error: Output file '$3' already exists."
    exit 1
fi

# Merged two files into one
cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3
echo "Done!"