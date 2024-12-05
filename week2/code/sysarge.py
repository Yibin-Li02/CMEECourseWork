#!/usr/bin/env python3

"""
A Python script to demonstrate the use of command-line arguments.

The script prints the following information:
1. The name of the script being executed.
2. The number of command-line arguments provided.
3. The list of command-line arguments.

This script is useful for understanding how to handle command-line arguments in Python using the `sys` module.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

import sys
print("This is the name of the script: ", sys.argv[0])
print("Number of arguments: ", len(sys.argv))
print("The arguments are: " , str(sys.argv))