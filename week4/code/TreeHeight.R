#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# This function calculates heights of trees given distance of each tree
# from its base and angle to its top, using  the trigonometric formula

# height = distance * tan(radians)

# Clear the workspace
rm(list=ls())

# Load the tree data from CSV
Tree_data <- tryCatch({
  read.csv("../data/trees.csv")  # Attempt to load the CSV file
}, error = function(e) {
  stop("Error: Could not load data. Please check the file path and format.")
})

# Define a function to calculate tree height given angle and distance
TreeHeight <- function(degrees, distance) {
  # Convert degrees to radians
  radians <- degrees * pi / 180

  # Calculate the height using the tangent of the angle
  height <- distance * tan(radians)

  # Print the calculated height
  print(paste("Tree height is:", height))

  # Return the height value
  return(height)
}

# Test the function with an angle of 37 degrees and a distance of 40 units
TreeHeight(37, 40)

# Calculate the height of trees in the dataset
Tree_data$Tree.Height.m <- Tree_data$Distance.m * tan(Tree_data$Angle.degrees * pi / 180)

# Save the updated dataset with tree heights to a CSV file
write.csv(Tree_data, row.names = FALSE, file = "../results/TreeHts.csv")