#!/usr/bin/env python3

"""
Some list comprehensions and for loops to print different attributes 
of birds from a tuple of tuples.
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
print('Latin names:', Bird_latin_names)


# List comprehension containing birds common names
Bird_common_names = [common_names[1] for common_names in birds]
print('Commom names:', Bird_common_names)

# List comprehension containing mean body masses
Bird_mean_body_masses = [mean_body_masses[2] for mean_body_masses in birds]
print('Mean_body_masses:', Bird_mean_body_masses)


# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

# Using conventional loops 

print("Using Conventional Loops")

# Conventional loop printing birds latin names
Bird_latin_names = []
for latin_names in birds:
    Bird_latin_names.append(latin_names[0])    
print('Latin names:', Bird_latin_names)

# Conventional loop printing birds common names
Bird_common_names = []
for common_names in birds:
    Bird_common_names.append(common_names[1])
print('Commom names:', Bird_common_names)

# Conventional loop printing birds mean body mass
Bird_mean_body_masses = []
for mean_body_masses in birds:
    Bird_mean_body_masses.append(mean_body_masses[2])
print('Mean_body_masses:', Bird_mean_body_masses) 