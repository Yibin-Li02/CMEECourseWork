## Author: Yibin.Li (Yibin.Li24@imperial.ac.uk)
## Version: 0.0.1

# Define a function called 'Exponential' that simulates exponential growth
# Arguments:
#   N0: Initial population size (default is 1)
#   r: Growth rate (default is 1)
#   generations: Number of generations to simulate (default is 10)
# Return Value:
#   A vector of length 'generations' representing the population size over time
Exponential <- function(N0 = 1, r = 1, generations = 10) {
  # Create a vector 'N' of length 'generations', initialized with NA values
  N <- rep(NA, generations)  
  
  # Set the initial population size
  N[1] <- N0
  
  # Loop through each generation to calculate population size
  for (t in 2:generations) {
    N[t] <- N[t-1] * exp(r)
    # Commenting out 'browser()' for production use to keep the code clean
    # Use 'browser()' in a dedicated sandbox for debugging purposes
    # browser()
  }
  
  # Return the vector containing population sizes for all generations
  return (N)
}

# Plot the results of the exponential growth simulation
# The 'type="l"' argument creates a line plot
plot(Exponential(), type="l", main="Exponential growth")
