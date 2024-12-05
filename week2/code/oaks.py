#!/usr/bin/env python3

"""
A Python script to filter oak trees from a list of species.

The script contains the following functionalities:
1. A function `is_an_oak` to identify oak trees from a list of species based on their genus name.
2. Using loops and list comprehensions to filter oak trees from the given list and print the results.
3. Converts oak tree names to uppercase using both loops and list comprehensions.

This script is useful for demonstrating how to filter specific taxa from a list and apply operations using different Python constructs.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

# List of taxa containing different species names
taxa = [
    'Quercus robur',
    'Fraxinus excelsior',
    'Pinus sylvestris',
    'Quercus cerris',
    'Quercus petraea',
]

def is_an_oak(name):
    """
    Determine if a given species is an oak tree.

    Args:
    name (str): The name of the species to be checked.

    Returns:
    bool: True if the species name starts with 'quercus', indicating it is an oak tree; False otherwise.
    """
    return name.lower().startswith('quercus ')

# Using for loops to filter oak trees
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species)
print("Oak trees using loops:", oaks_loops)

# Using list comprehensions to filter oak trees
oaks_lc = set([species for species in taxa if is_an_oak(species)])
print("Oak trees using list comprehensions:", oaks_lc)

# Get oak tree names in uppercase using for loops
oaks_loops = set()
for species in taxa:
    if is_an_oak(species):
        oaks_loops.add(species.upper())
print("Oak trees in uppercase using loops:", oaks_loops)

# Get oak tree names in uppercase using list comprehensions
oaks_lc = set([species.upper() for species in taxa if is_an_oak(species)])
print("Oak trees in uppercase using list comprehensions:", oaks_lc)