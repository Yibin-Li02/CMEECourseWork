#!/usr/bin/env python3

"""
A Python script to demonstrate storing and loading objects using pickle.

The script performs the following tasks:
1. Saves a dictionary object to a file using pickle for later use.
2. Loads the dictionary object back from the file and prints it.

This script is useful for understanding how to store Python objects in a binary format using the pickle module, 
allowing complex data to be serialized and deserialized for later use.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


import pickle

# STORING OBJECTS SECTION

# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}

# Open a file for writing in binary mode
f = open('../sandbox/testp.p', 'wb')

"""
Saves the dictionary object to a file using pickle.
"""

# Use pickle to serialize the dictionary object and save it to the file
pickle.dump(my_dictionary, f)

# Close the file after writing
f.close()

# LOADING OBJECTS SECTION

# Open the file for reading in binary mode
f = open('../sandbox/testp.p', 'rb')

"""
Loads the dictionary object from a file using pickle.
"""

# Use pickle to load the dictionary object from the file
another_dictionary = pickle.load(f)

# Close the file after reading
f.close()

# Print the loaded dictionary
print(another_dictionary)

