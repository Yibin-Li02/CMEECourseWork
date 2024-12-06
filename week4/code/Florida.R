#__author__ = 'Yibin.Li (Yibin.Li24@imperial.ac.uk)'
#__version__ = '0.0.1'
#__Date__ = November 2024

# Clear the environment
rm(list = ls())

# Load the data
load("../data/KeyWestAnnualMeanTemperature.RData")

# Check the data
print(ls())           # List the loaded objects
print(head(ats))      # Preview the data
print(class(ats))     # Confirm the class


# Calculate the observed correlation coefficient
obs_corr <- cor(ats$Year, ats$Temp)
cat("Observed correlation coefficient:", obs_corr, "\n")

# Permutation analysis
set.seed(123)  # Set seed for reproducibility
num_permutations <- 10000
random_corrs <- replicate(num_permutations, cor(ats$Year, sample(ats$Temp)))

# Calculate the p-value
p_value <- mean(random_corrs >= obs_corr)
cat("P-value from permutation test:", p_value, "\n")

# Save the plot to a PDF file
pdf("../results/Florida_Correlation_Histogram.pdf", width = 15, height = 8)

# Plot the random correlation coefficients with fixed x-axis
hist_data <- hist(random_corrs, breaks = 30, plot = FALSE)  # Store histogram data
hist(random_corrs, breaks = 30, 
     main = "Distribution of Random Correlation Coefficients",
     xlab = "Correlation Coefficient", ylab = "Frequency",
     col = "lightblue", border = "black", xlim = c(-0.6, 0.6), ylim = c(0, max(hist_data$counts) * 1.1))  # Extend y-axis for annotation
abline(v = obs_corr, col = "red", lwd = 2, lty = 2)  # Add observed correlation (red dashed line)

# Annotate the observed correlation coefficient on the plot (to the left of the red line)
text(x = obs_corr, 
     y = max(hist_data$counts) * 1.05,  # Place text just above the histogram bars
     labels = sprintf("Observed correlation coefficients: %.4f\n\nP-value: %.4f", obs_corr,p_value),
     col = "red", pos = 2, cex = 1, font = 2)  # Align text to the left of the x coordinate

# Close the PDF device
dev.off()

# Interpretation
if (p_value < 0.05) {
  cat("Result: The observed correlation is statistically significant.\n")
} else {
  cat("Result: The observed correlation is not statistically significant.\n")
}
