#!/usr/bin/env python3

"""
A Python script that demonstrates the use of list comprehensions and for loops to extract different attributes 
of birds from a tuple of tuples.

The script performs the following tasks:
1. Uses list comprehensions to create lists of Latin names, common names, and mean body masses of bird species.
2. Uses conventional for loops to achieve the same result for comparison purposes.

This helps illustrate the difference in readability and conciseness between list comprehensions and traditional loops.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'



# Raw data
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )


#### Solution here #### 

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

# List comprehension containing birds latin names

print("Using List Comprehensions")

Bird_latin_names = [latin_names[0] for latin_names in birds]
"""
Extracts the first element (Latin name) from each tuple in the birds list
"""
print('Latin names:', Bird_latin_names)


# List comprehension containing birds common names
Bird_common_names = [common_names[1] for common_names in birds]
"""
Extracts the second element (common name) from each tuple in the birds list
"""
print('Commom names:', Bird_common_names)

# List comprehension containing mean body masses
Bird_mean_body_masses = [mean_body_masses[2] for mean_body_masses in birds]
"""
Extracts the third element (mean body mass) from each tuple in the birds list
"""
print('Mean_body_masses:', Bird_mean_body_masses)


# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# Using conventional loops 

print("Using Conventional Loops")

# Conventional loop printing birds latin names
"""
Iterates through each bird tuple and appends the Latin name to Bird_latin_names list
"""
Bird_latin_names = []
for latin_names in birds:
    Bird_latin_names.append(latin_names[0])    
print('Latin names:', Bird_latin_names)

# Conventional loop printing birds common names
"""
Iterates through each bird tuple and appends the common name to Bird_common_names list
"""
Bird_common_names = []
for common_names in birds:
    Bird_common_names.append(common_names[1])
print('Commom names:', Bird_common_names)

# Conventional loop printing birds mean body mass
"""
Iterates through each bird tuple and appends the mean body mass to Bird_mean_body_masses list
"""
Bird_mean_body_masses = []
for mean_body_masses in birds:
    Bird_mean_body_masses.append(mean_body_masses[2])
print('Mean_body_masses:', Bird_mean_body_masses) 