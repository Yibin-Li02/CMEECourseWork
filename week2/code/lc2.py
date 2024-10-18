#!/usr/bin/env python3

"""
Some list comprehensions and loops to identify months with 
high and low rainfall from a given tuple of tuples.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'


# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

#### Solution here ####

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.


print("Using List Comprehensions")

rainfall_over_100 = [(month, amount) for month, amount in rainfall if amount > 100]
print(rainfall_over_100)


# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm.

rainfall_below_50 = [(month) for month, amount in rainfall if amount < 50]
print(rainfall_below_50)


# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !).

print("Using Conventional Loops")

rainfall_over_100 = []
for (month, amount) in rainfall:
    if amount > 100:
        rainfall_over_100.append((month, amount))  # Append a tuple
print(rainfall_over_100)


rainfall_below_50 = []
for month, amount in rainfall:
    if amount < 50:
        rainfall_below_50.append(month)
print(rainfall_below_50)