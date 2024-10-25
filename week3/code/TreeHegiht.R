#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'

# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT

# The heights of the tree, same units as "distance"
TreeHeight <- function(degrees, distance) {  # Define a function to calculate tree height given angle and distance
    radians <- degrees * pi / 180  # Convert degrees to radians (since trigonometric functions in R use radians)
    height <- distance * tan(radians)  # Calculate the height using the tangent of the angle
    print(paste("Tree height is:", height))  # Print the calculated height
  
    return(height)  # Return the height value
}

TreeHeight(37, 40)  # Test the function with an angle of 37 degrees and a distance of 40 units
