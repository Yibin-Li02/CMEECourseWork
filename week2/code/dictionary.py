#!/usr/bin/env python3

"""
A Python script to populate a dictionary from species data.

This script processes a list of species and their respective taxonomic orders, 
and creates a dictionary that maps each order to a set of species belonging to that order.
The script demonstrates two methods for populating the dictionary: using conventional loops
and using list comprehensions.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. 
# OR, 
# 'Chiroptera': {'Myotis  lucifugus'} ... etc

#### Solution here #### 

print("Using Conventional Loops")

# Create an empty dictionary to store the data
taxa_dic = {}

# Loop through the taxa list
for species, order in taxa:
    if order not in taxa_dic:
        taxa_dic[order] = set()  # Initialize a set if the order is not already in the dictionary
    taxa_dic[order].add(species)  # Add species to the respective order's set

# Print the dictionary
for order, species_set in taxa_dic.items():
    print(f"'{order}': {species_set}")


# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
#### Solution here #### 

print("Using List Comprehensions")

# Create an empty dictionary to store the data
taxa_dic = {}

# Populate the dictionary using a list comprehension
[taxa_dic.setdefault(order, set()).add(species) for species, order in taxa]

# Print the dictionary
for order, species_set in taxa_dic.items():
    print(f"'{order}': {species_set}")