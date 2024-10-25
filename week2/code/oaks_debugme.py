#!/usr/bin/env python3

"""
A Python script that finds oak in a given .csv file.

This script contains two functions, one that returns `True` if the genus is exactly 'quercus'.
Another function that prints 'FOUND AN OAK!' when an oak is found in all taxas and saves oak trees into a new csv file.
"""

__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
__version__ = '0.0.1'

import csv
import sys
import difflib
import doctest

# Define function
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
    TRUE
    >>> is_an_oak('Querc robur') 
    False
    >>> is_an_oak('Quercuspetraea')
    False
    """

    genus = name.split()[0].lower()  # Extract the genus name (first word)
    # Handle minor typos in genus name
    return difflib.get_close_matches(genus, ['quercus'], cutoff=0.8) != []

def main(argv):
    """
    Finds oaks and saves the results into a new csv file.
    """
    input_file = open('../data/TestOaksData.csv','r')
    output_file = open('../results/OaksData.csv','w')
    taxa = csv.reader(input_file)
    csvwrite = csv.writer(output_file)

    # Skip the header row in the input file
    header = next(taxa)

    # Write header to the output file
    csvwrite.writerow(['Genus', 'Species'])

    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')

        # adds oaks to csv file
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])
    input_file.close()
    output_file.close() 

    return 0
  
if __name__ == "__main__":
    """
    Makes sure the "main" function is called from the command line
    """
    import doctest
    doctest.testmod()
    status = main(sys.argv)
