#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'

# Define a function to calculate the mean of a resampled vector
doit <- function(x) {
    temp_x <- sample(x, replace = TRUE)  # Take a bootstrap sample from x with replacement
    if (length(unique(temp_x)) > 30) {  # Only calculate the mean if sample has more than 30 unique values
        print(paste("Mean of this sample was:", as.character(mean(temp_x))))  # Print the mean if condition is met
    } else {
        stop("Couldn't calculate mean: too few unique values!")  # Stop if there are too few unique values
    }
}

# Generate a population of random normal values
set.seed(1345)  # Set seed for reproducibility
popn <- rnorm(50)  # Generate a sample of 50 random normal values

hist(popn)  # Plot a histogram of the generated population

# Apply the 'doit' function 15 times to the population using lapply
lapply(1:15, function(i) doit(popn))  # Apply doit 15 times and print results

# Using try to handle errors gracefully
result <- lapply(1:15, function(i) try(doit(popn), FALSE))  # Try each 'doit' call and handle errors

# Check the class and contents of the result
class(result)  # Print the class of result (should be 'list')
result  # Print the content of the result list

# Preallocate a list for storing results
result <- vector("list", 15)  # Create an empty list of length 15
for (i in 1:15) {  # Loop 15 times
    result[[i]] <- try(doit(popn), FALSE)  # Store each 'doit' result in the list, handling errors
}
