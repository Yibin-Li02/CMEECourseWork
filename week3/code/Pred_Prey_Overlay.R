#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# Load necessary packages
require(tidyverse)

# Load data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

# Check the size and structure of the data frame
print(dim(MyDF))  # Print the dimensions of the data frame
str(MyDF)  # Display the internal structure of the data frame
head(MyDF)  # Show the first few rows to get a quick glimpse of the data

# Use glimpse from tidyverse to get a concise summary of the data
glimpse(MyDF)

# Convert columns to factors for better analysis
MyDF$Type.of.feeding.interaction <- as.factor(MyDF$Type.of.feeding.interaction)
MyDF$Location <- as.factor(MyDF$Location)  # Convert to factor
str(MyDF)  # Check the updated structure of the data frame

# Plot the relationship between predator and prey mass
plot(MyDF$Predator.mass, MyDF$Prey.mass)

# Use log transformation for better scaling
plot(log(MyDF$Predator.mass), log(MyDF$Prey.mass))

# Log10 transformation
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass))

# Change marker type
plot(log10(MyDF$Predator.mass), log10(MyDF$Prey.mass), pch = 20)

# Create histograms to analyze distributions
hist(MyDF$Predator.mass)
hist(log10(MyDF$Predator.mass),
     xlab = "log10(Predator Mass (g))",
     ylab = "Count",
     col = "lightblue",
     border = "pink")

# Initialize a multi-paneled plot for better comparison
par(mfcol=c(2,1)) #initialize multi-paneled plot
par(mfg = c(1,1)) # specify which sub-plot to use first
hist(log10(MyDF$Predator.mass),
     xlab = "log10(Predator Mass (g))",
     ylab = "Count", col = "lightblue", border = "pink",
     main = 'Predator') # Add title

# Second sub-plot
par(mfg = c(2,1))
hist(log10(MyDF$Prey.mass),
     xlab="log10(Prey Mass (g))",
     ylab="Count",
     col = "lightgreen",
     border = "pink", main = 'prey')

# Overlay histogram of predator and prey masses to visualize their overlap
hist(log10(MyDF$Predator.mass), # Predator histogram
     xlab="log10(Body Mass (g))", 
     ylab="Count",
     col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
     main = "Predator-prey size Overlap")

# Plot prey
hist(log10(MyDF$Prey.mass), col = rgb(0, 0, 1, 0.5), add = T)
legend('topleft',c('Predators','Prey'), # Add legend
       fill=c(rgb(1, 0, 0, 0.5), 
              rgb(0, 0, 1, 0.5))) # Define legend colors

# Boxplot to visualize variation in predator mass by different categories
boxplot(log10(MyDF$Predator.mass),
        xlab = "Location",
        ylab = "log10(Predator Mass)",
        main = "Predator mass")

# Boxplot to compare predator mass across different locations
boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # Why the tilde?
        xlab = "Location", ylab = "Predator Mass",
        main = "Predator mass by location")

# Boxplot to compare predator mass across feeding interaction types
boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
        xlab = "Location",
        ylab = "Predator Mass",
        main = "Predator mass by feeding interaction type")

# Save the predator-prey overlap plot to a PDF file
pdf("../results/Pred_Prey_Overlay.pdf",
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
     xlab="Body Mass (g)",
     ylab="Count",
     col = rgb(1, 0, 0, 0.5),
     main = "Predator-Prey Size Overlap")
hist(log(MyDF$Prey.mass), # Plot prey weights
     col = rgb(0, 0, 1, 0.5),
     add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
       fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5)))
graphics.off() #you can also use dev.off()