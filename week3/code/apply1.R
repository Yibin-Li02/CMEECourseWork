## Author: Yibin.Li (Yibin.Li24@imperial.ac.uk)
## Version: 0.0.1

# Create a random 10x10 matrix with values generated from a normal distribution
M <- matrix(rnorm(100), 10, 10)

# Calculate the mean of each row using the apply function
# The '1' indicates that the function is applied by rows
RowMeans <- apply(M, 1, mean)
print(RowMeans)  # Print the row means

# Calculate the variance of each row using the apply function
# Again, '1' indicates that the function is applied by rows
RowVars <- apply(M, 1, var)
print(RowVars)  # Print the row variances

# Calculate the mean of each column using the apply function
# The '2' indicates that the function is applied by columns
ColMeans <- apply(M, 2, mean)
print(ColMeans)  # Print the column means
