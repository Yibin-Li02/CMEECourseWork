#!/usr/bin/env python3

"""
A boilerplate Python script to serve as a template for future projects.

This script contains:
1. Metadata including app name, author, version, and license.
2. A main function that acts as the entry point of the program.
3. Standard imports for interfacing with the operating system.

The boilerplate can be extended to create various Python projects with a standardized format.
"""

__appname__ = '[Yibin.Li]'
__author__ = 'yl2524@ic.ac.uk)'
__version__ = '0.0.1'
__license__ = "License for this code/program"


## imports ##
import sys  # module to interface our program with the operating system

## functions ##
def main(argv):

    """
    Main entry point of the program.
    """

    print('This is a boilerplate')  # Print a boilerplate message
    return 0

if __name__ == "__main__": 

    """
    Ensures that the main function is called when the script is executed from the command line.
    """  

    status = main(sys.argv)  # Pass command-line arguments to the main function
    sys.exit(status)  # Exit with the status returned by the main function