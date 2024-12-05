#!/usr/bin/env python3

"""
A Python script to read and write CSV files.

The script performs the following tasks:
1. Reads a CSV file containing species information and prints each row along with the species name.
2. Writes a new CSV file containing only the species name and body mass from the original file.

This script is useful for demonstrating basic CSV operations in Python, including reading from and writing to CSV files.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

import csv

# Read a CSV file containing species information
with open('../data/testcsv.csv', 'r') as f:
    """
    Reads the input CSV file and prints each row, along with the species name.
    
    Args:
    f (file object): The CSV file to be read, containing columns like 'Species', 'Infraorder', 'Family', 'Distribution', and 'Body mass male (Kg)'.
    """
    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        # Print each row and the species name from the first column
        print(row)
        print("The species is", row[0])

# Write a CSV file containing only species name and body mass
with open('../data/testcsv.csv', 'r') as f:
    """
    Reads the input CSV file and writes a new CSV file containing only the species name and body mass.
    
    Args:
    f (file object): The CSV file to be read, containing columns like 'Species' and 'Body mass male (Kg)'.
    g (file object): The new CSV file to be written, containing only 'Species' and 'Body mass'.
    """
    with open('../data/bodymass.csv', 'w') as g:
        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            # Write the species name and body mass to the new CSV file
            print(row)
            csvwrite.writerow([row[0], row[4]])
