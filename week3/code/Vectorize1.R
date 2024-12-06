#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# Create a 1000x1000 matrix with random numbers
M <- matrix(runif(1000000), 1000, 1000)

# Sum All Elements in a Matrix Using Loops
SumAllElements <- function(M) {  # Define a function to sum all elements in the matrix using loops
  Dimensions <- dim(M)  # Get the dimensions of the matrix (rows and columns)
  Tot <- 0  # Initialize the total sum to 0
  for (i in 1:Dimensions[1]) {  # Loop over each row
    for (j in 1:Dimensions[2]) {  # Loop over each column
      Tot <- Tot + M[i, j]  # Add each element in the matrix to the total sum
    }
  }
  return(Tot)  # Return the total sum
}

# Measure the time taken to sum all elements using loops
print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))

# Measure the time taken to sum all elements using the in-built vectorized sum function
print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))