## Author: Yibin.Li (Yibin.Li24@imperial.ac.uk)
## Version: 0.0.1


# A simple script to illustrate R input-output.
# Run line by line and check inputs and outputs to understand what is happening

# Check if the CSV file exists before attempting to read it
# This prevents errors if the file is not found
if (file.exists("../data/trees.csv")) {

  # Import the dataset from a CSV file with headers
  MyData <- read.csv("../data/trees.csv", header = TRUE)

  # Write the data to a new CSV file
  write.csv(MyData, "../results/MyData.csv")

  # Append the first row of 'MyData' to the newly created CSV file
  # This adds the first row of data to the existing file without overwriting it
  write.table(MyData[1,], file = "../results/MyData.csv", append=TRUE)

  # Write the data to a new CSV file including row names
  # This will save the dataset with row names for reference,
  # which can be useful for indexing
  write.csv(MyData, "../results/MyData.csv", row.names = TRUE)
} else {
  print("The file '../data/trees.csv' does not exist.")
}

# Loop example to demonstrate conditional operations
# This loop iterates from 1 to 10
for (i in 1:10) {
  if (i == 10) {  # Check if the loop variable 'i' is equal to 10
    print("i is equal to 10")  # Print a message when 'i' is 10
  } else {
    print(paste("i is", i))  # Print the current value of 'i' if it is not 10
  }
}