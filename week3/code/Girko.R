#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# Load the ggplot2 package for plotting
require(ggplot2)

# Function to create an ellipse with specified horizontal and vertical radii
# hradius: horizontal radius of the ellipse
# vradius: vertical radius of the ellipse
build_ellipse <- function(hradius, vradius){
  npoints = 250
  a <- seq(0, 2 * pi, length = npoints + 1)
  x <- hradius * cos(a)
  y <- vradius * sin(a)
  return(data.frame(x = x, y = y))
}

# Assign size of the matrix
N <- 250

# Create an NxN matrix with random values from a normal distribution
M <- matrix(rnorm(N * N), N, N) # Build the matrix

# Calculate the eigenvalues of the matrix
eigvals <- eigen(M)$values # Find the eigenvalues

# Create a data frame containing the real and imaginary parts of the eigenvalues
# This will be used for visualization
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals))

# Calculate the radius of the ellipse, which is the square root of the matrix size (sqrt(N))
my_radius <- sqrt(N)

# Build a data frame for plotting the ellipse using the calculated radius
ellDF <- build_ellipse(my_radius, my_radius)

# Rename the columns of the ellipse data frame to "Real" and "Imaginary" for consistency
names(ellDF) <- c("Real", "Imaginary") # rename the columns

# plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
  geom_point(shape = I(3)) +
  theme(legend.position = "none")

# Add horizontal and vertical lines through the origin for reference
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))

# Add the ellipse representing the boundary within which most eigenvalues should lie
# The ellipse is filled with a transparent red color
p <- p + geom_polygon(data = ellDF,
                      aes(x = Real,
                          y = Imaginary,
                          alpha = 1/20,
                          fill = "red"))
p
