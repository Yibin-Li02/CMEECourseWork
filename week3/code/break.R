## Author: Yibin.Li (Yibin.Li24@imperial.ac.uk)
## Version: 0.0.1


# Initialize the variable 'i' to 0
i <- 0  

# Start an infinite while loop
# This loop will continue running until a break condition is met
while (i < Inf) {

  # Check if 'i' is equal to 10
  if (i == 10) {

    # Exit the loop if 'i' is equal to 10
    break
  } else {

    # If 'i' is not equal to 10, continue in the loop
    # Print the current value of 'i' with a formatted output
    cat("i equals", i, "\n")

    # Increment 'i' by 1 for the next iteration
    i <- i + 1
  }
}