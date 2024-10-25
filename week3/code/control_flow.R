#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'

# If statements
a <- TRUE  # Assigning the logical value TRUE to 'a'
if (a == TRUE) {  # Checking if 'a' is TRUE
    print("a is TRUE")  # Prints this if 'a' is TRUE
} else {
    print("a is FALSE")  # Prints this if 'a' is FALSE
}

z <- runif(1)  # Generate a random number between 0 and 1
if (z <= 0.5) {  # Checks if 'z' is less than or equal to 0.5
    print("Less than a half")  # Prints this if the condition is met
}

# For loops
for (i in 1:10) {  # Loop over numbers from 1 to 10
    j <- i * i  # Square the current value of 'i'
    print(paste(i, "squared is", j))  # Print the result with a message
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
