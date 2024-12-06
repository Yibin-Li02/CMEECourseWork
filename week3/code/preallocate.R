#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# Function without preallocation
NoPreallocFun <- function(x) {
  a <- vector()  # Create an empty vector
  for (i in 1:x) {  # Loop from 1 to x
    a <- c(a, i) # Concatenate i to the end of vector a, growing it with each iteration
    print(a)  # Print the current state of the vector
    print(object.size(a))  # Print the memory size of the vector a
  }
}

# Measure and print the time taken for NoPreallocFun
system.time(NoPreallocFun(10))

# Function with preallocation
PreallocFun <- function(x) {
  a <- rep(NA, x) # Create a vector of length x with NA values (pre-allocated)
  for (i in 1:x) {  # Loop from 1 to x
    a[i] <- i  # Assign the value i directly to the ith position in vector a
    print(a)  # Print the current state of the vector
    print(object.size(a))  # Print the memory size of the vector a
  }
}

# Measure and print the time taken for PreallocFun
system.time(PreallocFun(10))
