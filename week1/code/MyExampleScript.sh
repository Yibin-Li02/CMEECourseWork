#!/bin/sh
# Author: Yibin.Li24@imperial.ac.uk
# Script: MyExampleScript.sh
# Description: MyExampleScript
# Date: Oct 2024

# Check if the USER environment variable is set
if [ -z "$USER" ];
then
    echo "Error: USER environment variable not set."
    exit 1
fi

# Print the greeting
MSG1="Hello"
MSG2=$USER
echo "$MSG1 $MSG2"
echo "Hello $USER"
