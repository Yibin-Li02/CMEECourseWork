#!/usr/bin/env python3


"""
A Python script to print bird data from a tuple of tuples in a formatted manner.

The script iterates through each bird entry and prints the Latin name, common name, and mass 
of each bird in a structured format, making the information easy to read.

This script is useful for displaying bird data in a readable form.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by
# species 

#### Solution here #### 

# Iterate over each bird in the tuple and print its information in a formatted way
for latin_name, common_name, mass in birds:
    # Print the Latin name of the bird
    print(f"Latin Name: {latin_name}")
    # Print the common name of the bird
    print(f"Common Name: {common_name}")
    # Print the mass of the bird in grams
    print(f"Mass: {mass} g")
    # Print a separator line for better readability
    print("-")