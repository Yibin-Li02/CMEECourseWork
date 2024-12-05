#!/usr/bin/env python3

"""
A Python script demonstrating the use of the `__name__` variable.

The script contains the following functionalities:
1. Checks whether the script is being run directly or imported as a module.
2. Prints the name of the module using the `__name__` variable.

This script is useful for understanding how the `__name__` variable can be used to differentiate between running a script directly versus importing it as a module.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

if __name__ == '__main__':
    print('This program is being run by itself!')
else:
    print('I am being imported from another script/program/module!')

print("This module's name is: " + __name__)