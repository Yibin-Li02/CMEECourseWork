#!/usr/bin/env python3

"""
A Python script contain one function, is an oak, which used to find oak trees.
The results are saved to two rows and all the results will be printed.
"""

__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
__version__ = '0.0.1'

# Finds just those taxa that are oak trees from a list of species
taxa = [ 'Quercus robur',
         'Fraxinus excelsior',
         'Pinus sylvestris',
         'Quercus cerris',
         'Quercus petraea',
       ]

def is_an_oak(name):
    """
    This function is used to determine the oak trees.
    If the first parameter of taxa starts with 'quercus', then this taxa is the oak tree.
    """
    return name.lower().startswith('quercus ')

#Using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print(oaks_loops)

##Using list comprehensions   
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print(oaks_lc)

##Get names in UPPER CASE using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print(oaks_loops)

##Get names in UPPER CASE using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print(oaks_lc)