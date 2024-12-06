#!/usr/bin/env python3

"""
A Python script that demonstrates the use of various control flow techniques.

The script contains multiple functions that showcase different loop structures, 
including `for` loops, `while` loops, and control flow statements like `if`, `elif`, and `break`.

Each function prints 'hello' based on specific conditions, providing examples of how control flow can be utilized in Python.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


########################
def hello_1(x):

    """
    Prints 'hello' for each multiple of 3 within the range from 0 to x-1.
    """

    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')

hello_1(12)

########################
def hello_2(x):

    """
    Prints 'hello' if the current number meets certain modular conditions.
    Specifically, prints 'hello' if j % 5 == 3 or j % 4 == 3.
    """

    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)

########################
def hello_3(x, y):

    """
    Prints 'hello' for each value in the range from x to y-1.
    """

    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

########################
def hello_4(x):

    """
    Prints 'hello' in a `while` loop until x equals 15, incrementing x by 3 each time.
    """

    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)

########################
def hello_5(x):

    """
    Prints 'hello' based on specific conditions within a `while` loop until x is less than 100.
    Prints 'hello' seven times if x equals 31, otherwise prints 'hello' if x equals 18.
    """

    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)

########################
def hello_6(x, y):

    """
    Prints 'hello' along with the value of y in a `while` loop until y equals 6, then breaks.
    """
    
    while x:  # while x is True
        print("hello! " + str(y))
        y += 1  # increment y by 1 
        if y == 6:
            break
    print(' ')

hello_6(True, 0)
