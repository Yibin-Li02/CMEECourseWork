#!/usr/bin/env python3

"""
Mathematical functions demonstrating various programming concepts,
including iterative and recursive approaches, with detailed docstrings.
"""

__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
__version__ = '0.0.1'


# imports

import sys

def foo_1(x):

    """
    Calculate the square root of a number.

    Parameters:
        x (float): The number for which the square root is calculated.

    Returns:
        float: The square root of x.
    """

    return x ** 0.5

def foo_2(x, y):

    """
    Return the larger of two numbers.

    Parameters:
        x (float): The first number.
        y (float): The second number.

    Returns:
        float: The larger of x and y.
    """

    return x if x > y else y

def foo_3(x, y, z):

    """
    Return three numbers in ascending order.

    Parameters:
        x (float): The first number.
        y (float): The second number.
        z (float): The third number.

    Returns:
        list: A list of three numbers sorted in ascending order.
    """

    if x > y:
        x, y = y, x
    if y > z:
        y, z = z, y
    if x > y:
        x, y = y, x
    return [x, y, z]

def factorial(x, method="iterative"):

    """
    Calculate the factorial of a number using the specified method.

    Parameters:
        x (int): The number for which the factorial is calculated.

    Returns:
        int: The factorial of x.

    Raises:
        ValueError: If x is negative or method is not recognized.
    """

    if x < 0:
        raise ValueError("Factorial is not defined for negative numbers.")
    
    if method == "iterative":
        result = 1
        for i in range(1, x + 1):
            result *= i
        return result
    
    elif method == "recursive":
        if x == 0 or x == 1:
            return 1
        return x * factorial(x - 1, method="recursive")
    
    else:
        raise ValueError("Invalid method. Choose 'iterative' or 'recursive'.")

def main(argv):

    """
    Demonstrates the functionality of the implemented functions.
    """
    
    print(foo_1(16))
    print(foo_2(9, 100))
    print(foo_3(5, 2, 4))
    print(factorial(5, method="iterative"))
    print(factorial(5, method="recursive"))
    return 0   

if __name__ == "__main__":
    status = main(sys.argv)
    sys.exit(status)
