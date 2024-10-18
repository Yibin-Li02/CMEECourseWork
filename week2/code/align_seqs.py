#!/usr/bin/env python3

"""
A Python script that reads two DNA sequences from a CSV file, 
calculates the best alignment, and writes the results (best alignment and score) to a file.
"""

__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
__version__ = '0.0.1'

#imports
import csv
import sys

# Define input and output file paths
input_file_path = '../data/sequences.csv'  # Change this path as needed
output_file_path = '../results/Best_alignment.txt'  # Output file path

# Read sequences from CSV file
def read_sequences_from_csv(file_path):
    with open(file_path, mode='r') as file:
        reader = csv.reader(file)    
        sequences = [row[0] for row in reader]
    return sequences

# A function that computes a score by returning the number of matches
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = ""
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]:  # if the bases match
                matched += "*"
                score += 1
            else:
                matched += "-"
    
    return matched, score

def main():
    # Read sequences
    sequences = read_sequences_from_csv(input_file_path)
    if len(sequences) < 2:
        print("Please provide at least two sequences in the CSV file.")
        return
    
    seq1, seq2 = sequences[0], sequences[1]
    
    # Assign the longer sequence to s1, and the shorter to s2
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1  # swap the two lengths
    
    # Find the best match (highest score)
    my_best_align = None
    my_best_score = -1

    for i in range(l1):  # Check all possible starting points
        matched, score = calculate_score(s1, s2, l1, l2, i)
        if score > my_best_score:
            my_best_align = "." * i + s2  # Save best alignment
            my_best_score = score
    
    # Prepare output
    output_lines = [
        "The Best Alignment",
        s1,
        my_best_align,
        f"Best score: {my_best_score}"
    ]
    
    # Write output to file
    with open(output_file_path, 'w') as output_file:
        for line in output_lines:
            output_file.write(line + '\n')
    
sys.stdout.write(f"Best alignment saved to {output_file_path}")

if __name__ == "__main__":
    main()
