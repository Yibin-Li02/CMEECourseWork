#!/usr/bin/env python3

"""
A Python script to perform sequence alignment by calculating the optimal alignment between two DNA sequences.

The script contains:
1. A function to calculate the score of an alignment by matching characters from a given start point.
2. A loop that iterates through possible alignments to determine the best score.

The script takes two sequences, assigns the longer and shorter appropriately, and then finds the best alignment by calculating scores for each possible start point.
This script is useful for understanding how sequence alignment scoring works in bioinformatics.
"""

__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
__version__ = '0.0.1'

# Two example sequences to match
seq2 = "ATCGCCGGATTACGGG"
seq1 = "CAATTCGGAT"

# Assign the longer sequence to s1, and the shorter to s2
# l1 is the length of the longest sequence, l2 is that of the shortest
l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1  # swap the two lengths

def calculate_score(s1, s2, l1, l2, startpoint):
    """
    Computes the alignment score by returning the number of matches starting from a given start point.
    
    Args:
    s1 (str): The longer DNA sequence.
    s2 (str): The shorter DNA sequence.
    l1 (int): Length of the longer sequence.
    l2 (int): Length of the shorter sequence.
    startpoint (int): The index in s1 from which to start the alignment.
    
    Returns:
    int: The score of the alignment.
    """
    matched = ""  # Holds the string displaying alignments
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]:  # if the bases match
                matched += "*"
                score += 1
            else:
                matched += "-"

    # Print formatted output for alignment visualization
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print("Score:", score)
    print(" ")

    return score

# Find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1):  # Iterate through all possible start points for alignment
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2  # Store the best alignment
        my_best_score = z

# Print the best alignment and its score
print("Best alignment:")
print(my_best_align)
print(s1)
print("Best score:", my_best_score)


