#!/usr/bin/env python3

"""
This script contains 5 code examples demonstrating the concept of variable scope in Python, 
including global and local variables, and the use of the `global` keyword within nested functions.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


## Script 1
_a_global = 10 # a global variable

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable
   
print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function():

    """
    Demonstrates local scope by defining local variables inside the function.
    """    

    _a_global = 4 # a local variable
  
    if _a_global >= 4:
        _b_global = _a_global + 5 # also a local variable
  
    _a_local = 3
  
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)

# The following line will cause an error because _a_local is not defined in the global scope
print("After calling a_function, outside the function, the value of _a_local is ", _a_local)



## Script 2
_a_global = 10

def a_function():

    """
    Demonstrates the use of a local variable alongside a global variable.
    """

    _a_local = 4
    
    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)
    
a_function()

print("Outside the function, the value of _a_global is", _a_global)



## Script 3
_a_global = 10

print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():

    """
    Demonstrates modifying a global variable using the `global` keyword.
    """

    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value _a_local is", _a_local)
    
a_function()

print("After calling a_function, outside the function, the value of _a_global now is", _a_global)



## Script 4
def a_function():

    """
    Demonstrates nested functions and the use of the `global` keyword within a nested function.
    """

    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)
    
a_function()

print("The value of a_global in main workspace / namespace now is", _a_global)



## Script 5

a_global = 10

"""
Demonstrates modifying a global variable from within a nested function.
"""

def a_function():

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function2, value of _a_global is", _a_global)

    _a_function2()
    
    print("After calling a_function2, value of _a_global is", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is", _a_global)