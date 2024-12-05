#!/usr/bin/env python3

"""
A Python script to demonstrate basic file input operations.

The script performs the following tasks:
1. Reads and prints each line of a text file using an implicit loop.
2. Reads and prints each non-blank line of the text file.

This script is useful for understanding basic file handling in Python, including reading files and skipping empty lines.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

# FILE INPUT SECTION

# Open a file for reading
f = open('../sandbox/test.txt', 'r')
"""
Reads the file line by line and prints each line.

Args:
    f (file object): The text file to be read.
"""
# Use "implicit" for loop to iterate over lines of the file
for line in f:
    print(line)

# Close the file after reading
f.close()

# Open the file again for reading
f = open('../sandbox/test.txt', 'r')
"""
Reads the file line by line and prints only non-blank lines.

Args:
    f (file object): The text file to be read.
"""
# Iterate over lines and skip blank lines
for line in f:
    if len(line.strip()) > 0:  # Check if the line is not blank
        print(line)

# Close the file after reading
f.close()
