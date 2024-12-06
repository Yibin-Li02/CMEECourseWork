#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# Load the ggplot2 library for creating plots
library(ggplot2)

# Generate a sequence of values from 0 to 100 with an increment of 0.1
x <- seq(0, 100, by = 0.1)

# Generate the dependent variable 'y' based on a linear relationship with 'x',
# adding random noise using rnorm to simulate real-world variability.
y <- -4. + 0.25 * x + rnorm(length(x), mean = 0., sd = 2.5)

# Combine 'x' and 'y' into a dataframe for easy manipulation
my_data <- data.frame(x = x, y = y)

# Perform a linear regression to find the relationship between 'x' and 'y'
my_lm <- summary(lm(y ~ x, data = my_data))

# Plot the data points using ggplot2
p <- ggplot(my_data, aes(x = x,
                         y = y,
                         colour = abs(my_lm$residual))) +
  geom_point() +  # Plot the data points
  scale_colour_gradient(low = "black", high = "red") +  # Gradient color from black to red based on residuals
  theme(legend.position = "none") +  # Remove the legend
  scale_x_continuous(expression(alpha^2 * pi / beta * sqrt(Theta)))

# Add the regression line to the plot
p <- p + geom_abline(intercept = my_lm$coefficients[1][1], # Extract the intercept from the linear model
                     slope = my_lm$coefficients[2][1], # Extract the slope from the linear model
                     colour = "red")  # Color the regression line red

# Add a mathematical annotation to the plot
p <- p + geom_text(aes(x = 60,
                       y = 0,
                       label = "sqrt(alpha) * 2* pi"), # Define the position and content of the text
                       parse = TRUE, # Parse the label as a mathematical expression
                       size = 6,  # Set the font size of the text
                       colour = "blue")# Color the text blue

# Display the plot
print(p)

# Save the plot to a PDF file
ggsave("../results/MyLinReg.pdf", plot = p)
