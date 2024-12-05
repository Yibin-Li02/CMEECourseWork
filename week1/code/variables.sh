#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: variables.sh
# Description: Demonstrates the use of variables, including special variables, user input, and arithmetic operations.
# Date: Oct 2024

# Special variables
# $# - Number of arguments passed to the script
# $0 - The name of the script
# $@ - All the arguments passed to the script
# $1, $2, etc. - The first, second, etc., arguments passed to the script
echo "This script was called with $# parameters"
echo "The script's name is $0"
echo "The arguments are $@"
echo "The first argument is $1"
echo "The second argument is $2"

# Assigned Variables; Explicit declaration:
# MY_VAR is assigned a string value and then modified based on user input
MY_VAR='some string' 
echo 'the current value of the variable is:' $MY_VAR
echo

# Prompt the user to enter a new value for MY_VAR
echo 'Please enter a new string'
read MY_VAR
echo
echo 'the current value of the variable is:' $MY_VAR
echo

# Assigned Variables; Reading (multiple values) from user input:
# Prompt the user to enter two numbers separated by spaces
echo 'Enter two numbers separated by space(s)'
read a b
echo
echo 'you entered' $a 'and' $b '; Their sum is:'

# Assigned Variables; Command substitution
# Calculate the sum of the two numbers using arithmetic substitution
MY_SUM=$(($a + $b))
echo $MY_SUM
