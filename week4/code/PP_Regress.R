#__author__ = 'Yibin.Li Yibin.Li24@imperial.ac.uk'
#__version__ = '0.0.1'


# Clear the workspace
rm(list = ls())

# Load necessary libraries
library(ggplot2)
library(dplyr)

# Read and summarize data
data <- read.csv("../data/EcolArchives-E089-51-D1.csv")
str(data)

table(data$Type.of.feeding.interaction)
table(data$Predator.lifestage)

# Fix the unit error for prey mass
data <- data %>%
  mutate(Prey.mass.grams =
           ifelse(Prey.mass.unit == "mg", Prey.mass / 1000, Prey.mass))

# Fit a linear model
model <- lm(Predator.mass ~ Prey.mass.grams +
              Predator.lifestage +
              Type.of.feeding.interaction,
            data = data)
summary(model)

# Check ranges for predator and prey mass
range(data$Prey.mass.grams, na.rm = TRUE)
range(data$Predator.mass, na.rm = TRUE)

# Find unique combinations of feeding type and predator life stage
combinations <- distinct(data, Type.of.feeding.interaction, Predator.lifestage)

# Initialize a dataframe to store regression results
regression_results <- data.frame(
  Type.of.feeding.interaction = character(),
  Predator.lifestage = character(),
  slope = numeric(),
  intercept = numeric(),
  r_squared = numeric(),
  f_statistic = numeric(),
  p_value = numeric(),
  stringsAsFactors = FALSE
)

# Loop through each combination to perform regression
for (i in 1:nrow(combinations)) {
  feeding_type <- combinations$Type.of.feeding.interaction[i]
  predator_stage <- combinations$Predator.lifestage[i]

  # Filter data for the current combination
  subset_data <- data %>%
    filter(Type.of.feeding.interaction == feeding_type,
           Predator.lifestage == predator_stage)

  # Check if there are enough data points for regression
  if (nrow(subset_data) > 2) {
    model <- lm(Predator.mass ~ Prey.mass.grams, data = subset_data)
    model_summary <- summary(model)

    # Store regression results
    regression_results <- rbind(regression_results, data.frame(
      Type.of.feeding.interaction = feeding_type,
      Predator.lifestage = predator_stage,
      slope = coef(model)[2],
      intercept = coef(model)[1],
      r_squared = model_summary$r.squared,
      f_statistic = model_summary$fstatistic[1],
      p_value = coef(model_summary)[2, 4]
    ))
  } else {
    # Store NA if not enough data
    regression_results <- rbind(regression_results, data.frame(
      Type.of.feeding.interaction = feeding_type,
      Predator.lifestage = predator_stage,
      slope = NA,
      intercept = NA,
      r_squared = NA,
      f_statistic = NA,
      p_value = NA
    ))
  }
}

# Save regression results to CSV
write.csv(regression_results, file = "../results/PP_Regression.csv", row.names = FALSE)

# Visualization of predator-prey mass relationships
p <- ggplot(data, aes(x = Prey.mass, y = Predator.mass, colour = Predator.lifestage)) +
  geom_point(shape = I(3), size = I(1.5)) +  # Scatter points
  geom_smooth(method = "lm", fullrange = TRUE) +  # Linear model smoothing
  facet_wrap(~ Type.of.feeding.interaction, nrow = 5, strip.position = "right") +  # Facet by Feeding Type
  labs(
    x = "Prey Mass in grams",
    y = "Predator Mass in grams",
    color = "Predator Life Stage"
  ) +
  theme_minimal() +
  theme(
    strip.text = element_text(size = 8, face = "bold"),
    strip.background = element_rect(fill = "grey90", color = NA),
    legend.position = "bottom",
    legend.box = "horizontal",
    legend.direction = "horizontal", 
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 8),
    axis.text = element_text(size = 8),
    axis.title = element_text(size = 10),
    plot.title = element_text(angle = -90, vjust = 0.5, hjust = 0.5, size = 12, face = "bold"),
    plot.title.position = "plot" , 
    panel.border = element_rect(color = "black", fill = NA, size = 0.5)
  ) +
  guides(colour = guide_legend(nrow = 1)) +
  scale_x_log10() + 
  scale_y_log10() +
  coord_fixed(ratio = 0.4)

#Save the picture as PDF
ggsave("../results/PP_Regression.pdf", plot = p, width = 10, height = 8)
