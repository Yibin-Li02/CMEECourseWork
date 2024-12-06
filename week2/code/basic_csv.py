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


# imports
import csv

import csv

# Read a file containing:
# 'Species','Infraorder','Family','Distribution','Body mass male (Kg)'
with open('../data/testcsv.csv','r') as f:

    csvread = csv.reader(f)
    temp = []
    for row in csvread:
        temp.append(tuple(row))
        print(row)
        print("The species is", row[0])

# write a file containing only species name and Body mass
with open('../data/testcsv.csv','r') as f:
    with open('../data/bodymass.csv','w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0], row[4]])

