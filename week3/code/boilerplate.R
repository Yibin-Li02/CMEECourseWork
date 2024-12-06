## Author: Yibin.Li (Yibin.Li24@imperial.ac.uk)
## Version: 0.0.1


# A boilerplate R script demonstrating a simple function definition and usage

# Define a function called 'MyFunction' that takes two arguments: Arg1 and Arg2
# Arguments:
#   Arg1: The first argument, can be of any type (e.g., numeric, character)
#   Arg2: The second argument, can be of any type (e.g., numeric, character)
# Return Value:
#   A concatenated vector containing 'Arg1' and 'Arg2'
MyFunction <- function(Arg1, Arg2) {

  # Print the type of 'Arg1'
  print(paste("Argument", as.character(Arg1), "is a", class(Arg1)))

  # Print the type of 'Arg2'
  print(paste("Argument", as.character(Arg2), "is a", class(Arg2)))

  # Return a concatenated vector of 'Arg1' and 'Arg2'
  return (c(Arg1, Arg2))
}

# Test the function with numeric arguments
MyFunction(1, 2)

# Test the function with character arguments
MyFunction("Riki", "Tiki")
