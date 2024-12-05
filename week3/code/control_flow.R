## Author: Yibin.Li (Yibin.Li24@imperial.ac.uk)
## Version: 0.0.1

# Control Flow Examples in R

# If statements: Demonstrates conditional branching based on the value of a variable
# This structure allows for different actions depending on whether a condition is TRUE or FALSE
a <- TRUE  # Assigning the logical value TRUE to 'a'
if (a == TRUE) {  # Checking if 'a' is TRUE
    print("a is TRUE")  # Prints this if 'a' is TRUE
} else {
    print("a is FALSE")  # Prints this if 'a' is FALSE
}

# If statement with random value: Demonstrates a conditional check on a randomly generated value
# This control structure is useful for probabilistic decisions or branching
z <- runif(1)  # Generate a random number between 0 and 1
if (z <= 0.5) {  # Checks if 'z' is less than or equal to 0.5
    print("Less than a half")  # Prints this if the condition is met
}

# For loop: Demonstrates iteration over a sequence
# This structure is used for repetitive tasks, such as processing each element in a sequence
for (i in 1:10) {  # Loop from 1 to 10
    print(paste("i is", i))  # Print the current value of 'i'
}

# While loop: Demonstrates repeating an action until a condition is no longer met
# Useful when the number of iterations is not known in advance
i <- 0  # Initialize 'i' to 0
while (i < 10) {  # Continue looping while 'i' is less than 10
    print(paste("i is", i))  # Print the current value of 'i'
    i <- i + 1  # Increment 'i' by 1
}

1:10  # This simply generates a sequence of numbers from 1 to 10

for (species in c('Heliodoxa rubinoides', 
                  'Boissonneaua jardini', 
                  'Sula nebouxii')) {  # Loop over each species name
      print(paste('The species is', species))  # Print each species name
}

v1 <- c("a","bc","def")  # Create a vector of strings
for (i in v1) {  # Loop over each element in 'v1'
    print(i)  # Print the current element
}

# While loop
i <- 0  # Initialize 'i' to 0
while (i < 10) {  # Continue looping while 'i' is less than 10
    i <- i + 1  # Increment 'i' by 1
    print(i^2)  # Print the square of the current value of 'i'
}