#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'

# Function to check if an integer is even or odd
is.even <- function(n = 2) {  # Default value of 'n' is 2
  if (n %% 2 == 0) {  # Check if 'n' is divisible by 2 with no remainder
    return(paste(n, 'is even!'))  # If true, return that 'n' is even
  } else {
    return(paste(n, 'is odd!'))  # Otherwise, return that 'n' is odd
  }
}

is.even(6)  # Test the function with the input 6


# Function to check if a number is a power of 2
is.power2 <- function(n = 2) {  # Default value of 'n' is 2
  if (log2(n) %% 1 == 0) {  # Check if log2 of 'n' is an integer (i.e., no remainder)
    return(paste(n, 'is a power of 2!'))  # If true, return that 'n' is a power of 2
  } else {
    return(paste(n, 'is not a power of 2!'))  # Otherwise, return that 'n' is not a power of 2
  }
}

is.power2(4)  # Test the function with the input 4


# Function to check if a number is prime
is.prime <- function(n) {
  if (n == 0) {  # Check if 'n' is zero
    return(paste(n, 'is a zero!'))  # If true, return that 'n' is zero
  } else if (n == 1) {  # Check if 'n' is one
    return(paste(n, 'is just a unit!'))  # If true, return that 'n' is a unit
  }
  
  ints <- 2:(n - 1)  # Create a sequence of integers from 2 to n-1
  
  if (all(n %% ints != 0)) {  # Check if 'n' is not divisible by any number in 'ints'
    return(paste(n, 'is a prime!'))  # If true, return that 'n' is prime
  } else {
    return(paste(n, 'is a composite!'))  # Otherwise, return that 'n' is composite
  }
}

is.prime(3)  # Test the function with the input 3
