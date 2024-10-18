#!/usr/bin/env python3

"""
Six mathematical functions showing different conditionals,
including doctests for each function.
"""

__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
__version__ = '0.0.1'

# imports

import sys

"""
Finds the square root.
"""

def foo_1(x):
    return x ** 0.5


"""
Returns the largest of two numbers.
"""

def foo_2(x, y):
    if x > y:
        return x
    return y

"""
Returns 3 numbers in a different order.
"""

def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

"""
Calculates the factorial of x.
"""

def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

"""
A recursive function that calculates the factorial of x.
"""

def foo_5(x): 
    if x == 1:
        return 1
    return x * foo_5(x - 1)
     

"""
Calculates the factorial of x, multiplying from x down to 1.
"""

def foo_6(x):
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

def main(argv):
    print(foo_1(16))
    print(foo_2(9, 100))
    print(foo_3(5, 2, 4))
    print(foo_4(5))
    print(foo_5(5))
    print(foo_6(5))
    return 0   

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)