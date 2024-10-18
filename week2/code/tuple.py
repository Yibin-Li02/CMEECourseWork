#!/usr/bin/env python3

"""
Prints data from a tuple of tuples in a different way.
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

# Iterate over each bird in the tuple and print its information
for latin_name, common_name, mass in birds:
    print(f"Latin Name: {latin_name}")
    print(f"Common Name: {common_name}")
    print(f"Mass: {mass}")