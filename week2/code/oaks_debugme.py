#!/usr/bin/env python3

"""
A Python script that finds oak in a given .csv file.
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
    Returns True if the genus name starts with 'quercus', False otherwise.
    
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
    >>> is_an_oak('Quercuss robur')  # Typo in 'Quercus'
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
    input_file = open('../data/TestOaksData.csv','r')
    output_file = open('../results/JustOaksData.csv','w')
    taxa = csv.reader(input_file)
    csvwrite = csv.writer(output_file)

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

    return 0
    
if __name__ == "__main__":
    import doctest
    doctest.testmod()
    status = main(sys.argv)
