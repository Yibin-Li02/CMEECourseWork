#!/usr/bin/env python3

"""
A Python script demonstrating the use of `for` and `while` loops.

The script contains the following examples:
1. A `for` loop that iterates over a range of numbers and prints each number.
2. A `for` loop that iterates over elements of a list and prints each element.
3. A `for` loop that sums the elements of a list and prints the running total.
4. A `while` loop that increments a value until it reaches a specified limit, printing each increment.

These examples are useful for understanding basic looping constructs in Python.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


# FOR loops

# Iterates over a range of numbers from 0 to 4 and prints each number
for i in range(5):

    """
    Print each number from 0 to 4.
    """
    
    print(i)

# Iterates over each element in a list and prints it
my_list = [0, 2, "geronimo!", 3.0, True, False]
for k in my_list:

    """
    Print each element in the list `my_list`.
    
    Args:
    k: The current element in the list, which can be of any type.
    """
    
    print(k)

# Iterates over a list of numbers, calculates the running total, and prints it
total = 0
summands = [0, 1, 11, 111, 1111]
for s in summands:

    """
    Calculate and print the running total of the elements in the list `summands`.
    
    Args:
    s (int): The current element to add to the running total.
    """

    total = total + s
    print(total)

# WHILE loop

# Increment a value until it reaches 100 and print each value
z = 0
while z < 100:

    """
    Increment `z` by 1 until it reaches 100 and print each value.
    
    Args:
    z (int): The current value, starting from 0 and ending at 100.
    """
    
    z = z + 1
    print(z)
