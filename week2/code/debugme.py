#!/usr/bin/env python3

"""
A Python script containing a function with a potential bug for demonstration purposes.

The script contains:
1. A function `buggyfunc` that performs some arithmetic operations in a loop.
2. A call to `buggyfunc` with an argument of 20, which may lead to a runtime error due to division by zero.

This script is useful for demonstrating debugging techniques and identifying common issues such as division by zero.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


# Function with a potential bug
def buggyfunc(x):

    """
    A function that performs arithmetic operations in a loop, which may contain a bug.

    Returns:
    float: The result of the division operation.
    """
    
    y = x
    for i in range(x):
        y = y - 1  # Decrement y by 1
        z = x / y  # Potential division by zero if y becomes 0
    return z

# Call the function with a sample value
buggyfunc(20)
