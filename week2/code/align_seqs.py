#!/usr/bin/env python3

"""
A Python script that reads two DNA sequences from a CSV file.

Calculates the best alignment, and saves the results (best alignment and score) to a file.

The script has several functions, including reading sequences from a CSV file, 
calculating the alignment score, and finding the best alignment.

If no input files are given, the default files are used.
"""

__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
__version__ = '0.0.1'


# Imports
import csv
import sys
import os

# Define input and output file paths
input_file_path = '../data/sequences.csv'  # Change this path as needed
output_file_path = '../results/Best_alignment.txt'  # Output file path

# Read sequences from CSV file
def read_sequences_from_csv(file_path):

    """
    Reads DNA sequences from a given CSV file.
    
    Parameters:
    file_path (str): Path to the CSV file containing DNA sequences.
    
    Returns:
    list: A list of sequences read from the file.
    
    Raises:
    FileNotFoundError: If the file does not exist.
    """

    if not os.path.exists(file_path):
        raise FileNotFoundError(f"The file '{file_path}' does not exist.")
    
    with open(file_path, mode='r') as file:
        reader = csv.reader(file)
        sequences = [row[0] for row in reader]
    
    if len(sequences) < 2:
        raise ValueError("Please provide at least two sequences in the CSV file.")
    
    return sequences

# A function that computes a score by returning the number of matches
def calculate_score(s1, s2, l1, l2, startpoint):

    """
    Calculate the result score of two sequences aligment.
    The score is determined by the matching base pairs.
    """

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

# Function to find the best alignment
def find_best_alignment(s1, s2):

    """
    Reading sequences from a CSV file and ensuring that there are at least two sequences to proceed.
    If the condition is true, which means less than two sequences, a message is printed and exists the function.
    """

    l1 = len(s1)
    l2 = len(s2)
    best_align = None
    best_score = -1
    
    for i in range(l1):  # Check all possible starting points
        _, score = calculate_score(s1, s2, l1, l2, i)
        if score > best_score:
            best_align = "." * i + s2  # Save best alignment
            best_score = score
    
    return best_align, best_score

# Function to write alignment results to a file
def write_alignment_to_file(output_path, s1, best_align, best_score):

    """
    Writes the best alignment result to a file.
    
    Parameters:
    output_path (str): Path to the output file.
    s1 (str): The longer DNA sequence.
    best_align (str): The best alignment string.
    best_score (int): The best score of the alignment.
    """

    output_lines = [
        "The Best Alignment",
        s1,
        best_align,
        f"Best score: {best_score}"
    ]
    
    with open(output_path, 'w') as output_file:
        for line in output_lines:
            output_file.write(line + '\n')

# Main function to execute the alignment logic
def main():

    """
    Main function to read sequences, find the best alignment, and write the results to a file.
    
    Raises:
    Exception: If any error occurs during reading or processing sequences.
    """
    
    try:
        sequences = read_sequences_from_csv(input_file_path)
        seq1, seq2 = sequences[0], sequences[1]
        
        # Assign the longer sequence to s1, and the shorter to s2
        if len(seq1) >= len(seq2):
            s1, s2 = seq1, seq2
        else:
            s1, s2 = seq2, seq1
        
        # Find the best match (highest score)
        best_align, best_score = find_best_alignment(s1, s2)
        
        # Write output to file
        write_alignment_to_file(output_file_path, s1, best_align, best_score)
        
        sys.stdout.write(f"Best alignment saved to {output_file_path}\n")
    except Exception as e:
        sys.stderr.write(f"Error: {e}\n")

if __name__ == "__main__":
    main()