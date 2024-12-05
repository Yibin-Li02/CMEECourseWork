#!/usr/bin/env python3

"""
A Python script demonstrating the use of a simple function.

The script contains the following example:
1. A function `foo` that takes an argument, squares it, and prints the result.

This example is useful for understanding basic function operations in Python.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

# Function definition
def foo(x):
    """
    Squares the input value and prints the result.
    
    Args:
    """
    x *= x  # Multiply x by itself (same as x = x * x)
    print(x)

# Function call
foo(2)
