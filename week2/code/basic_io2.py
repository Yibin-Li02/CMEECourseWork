#!/usr/bin/env python3

"""
A Python script demonstrating basic file output operations.

The script performs the following tasks:
1. Creates a list of numbers from 0 to 99.
2. Writes each element of the list to a text file, with each number on a new line.

This script is useful for understanding basic file writing operations in Python, including writing data to text files.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


# FILE OUTPUT SECTION

# Save the elements of a list to a file
list_to_save = range(100)  # Create a range object containing numbers from 0 to 99

# Open a file for writing
f = open('../sandbox/testout.txt', 'w')

"""
Writes each element of the list to a file, with each element on a new line.
"""

for i in list_to_save:
    f.write(str(i) + '\n')  # Write each element to the file and add a newline

# Close the file after writing
f.close()
