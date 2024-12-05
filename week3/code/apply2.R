## Author: Yibin.Li (Yibin.Li24@imperial.ac.uk)
## Version: 0.0.1

# Define a function called 'SomeOperation' that operates on a vector 'v'
SomeOperation <- function(v) {
  # If the sum of all elements in the vector is greater than 0
  if (sum(v) > 0) {  # 'sum(v)' is a scalar value representing the sum of all elements in 'v'
    return (v * 100)  # Multiply all elements in the vector by 100 and return the result
  } else {
    return (v)  # If the sum is not greater than 0, return the original vector
  }
}

# Create a random 10x10 matrix with values generated from a normal distribution
M <- matrix(rnorm(100), 10, 10)

# Apply the 'SomeOperation' function to each row of the matrix
# The '1' indicates that the function is applied by rows
print(apply(M, 1, SomeOperation))  # Print the resulting matrix after applying 'SomeOperation'
