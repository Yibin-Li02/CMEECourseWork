#!/usr/bin/env python3

"""
A Python script that finds oak in a given .csv file.

This script contains two functions, one that returns `True` if the genus is exactly 'quercus'.
Another function that prints 'FOUND AN OAK!' when an oak is found in all taxas and saves oak trees into a new csv file.
"""

__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
__version__ = '0.0.3'

import csv
import sys
import difflib
import doctest
import os

def is_an_oak(name):
    """
    Returns True if the genus name starts with 'quercus'.
    
    Handles cases where 'Quercus' might have a minor typo, e.g., 'Quercuss'.
    
    >>> is_an_oak('Quercus robur')
    True
    >>> is_an_oak('quercus robur')
    True
    >>> is_an_oak('Quercus cerris')
    True
    >>> is_an_oak('quercus petraea')
    True
    >>> is_an_oak('Fagus sylvatica')
    False
    >>> is_an_oak('Quercuss robur')
    True
    >>> is_an_oak('Querc robur') 
    False
    >>> is_an_oak('Quercuspetraea')
    False
    >>> is_an_oak('')
    False
    >>> is_an_oak('    ')
    False
    >>> is_an_oak('Quercus123')
    False
    >>> is_an_oak('Que rcus robur') 
    False
    >>> is_an_oak('Quércus robur') 
    False
    """
    genus = name.split()[0].lower()  # Extract the genus name (first word)
    # Handle minor typos in genus name
    return difflib.get_close_matches(genus, ['quercus'], cutoff=0.8) != []

def main(argv):
    """
    Finds oaks and saves the results into a new csv file.
    """
    input_file_path = '../data/TestOaksData.csv'
    output_file_path = '../results/OaksData.csv'

    # Check if input file exists
    if not os.path.exists(input_file_path):
        print(f"Error: The input file '{input_file_path}' does not exist.")
        sys.exit(1)

    try:
        with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
            taxa = csv.reader(input_file)
            csvwrite = csv.writer(output_file)

            # Skip the header row in the input file
            header = next(taxa)

            # Write header to the output file
            csvwrite.writerow(['Genus', 'Species'])

            for row in taxa:
                if len(row) < 2:
                    print(f"Warning: Incomplete data row: {row}")
                    continue
                
                print(row)
                print("The genus is: ")
                print(row[0] + '\n')

                # Adds oaks to csv file
                if is_an_oak(row[0]):
                    print('FOUND AN OAK!\n')
                    csvwrite.writerow([row[0], row[1]])
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

    sys.exit(0)
  
if __name__ == "__main__":
    """
    Makes sure the "main" function is called from the command line
    """
    import doctest
    doctest.testmod()
    main(sys.argv)

