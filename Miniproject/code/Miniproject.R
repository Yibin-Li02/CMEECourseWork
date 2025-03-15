# Load necessary libraries
library(dplyr)
library(readr)

# Load the data
growth_data <- read_csv("../data/LogisticGrowthData.csv")

# Total rows in the original dataset
original_row_count <- nrow(growth_data)

# Standardize column names (lowercase)
colnames(growth_data) <- tolower(colnames(growth_data))

# Ensure all necessary columns exist
required_cols <- c("time", "popbio", "temp", "species", "medium", "citation", "rep", "popbio_units", "time_units")  
missing_cols <- setdiff(required_cols, colnames(growth_data))

if (length(missing_cols) > 0) {
  stop(paste("Missing columns in growth data:", paste(missing_cols, collapse = ", ")))
}

# Remove rows with non-positive values (not log-transformable)
growth_data <- growth_data %>%
  filter(time > 0, popbio > 0)

# Count rows after removing non-positive values
cleaned_row_count <- nrow(growth_data)
rows_removed <- original_row_count - cleaned_row_count

# Create a combined categorical ID (excluding rep)
growth_data <- growth_data %>%
  mutate(
    subset_category = paste(species, temp, medium, citation, sep = "_")
  )

# Assign unique numeric ID for each subset
growth_data <- growth_data %>%
  mutate(subset_id = as.integer(as.factor(subset_category)))

# Add log-transformed columns
growth_data <- growth_data %>%
  mutate(
    log_popbio = log(popbio),
    log_time = log(time)
  )

# Sort data by subset_id and Time
growth_data <- growth_data %>%
  arrange(subset_id, time)

# Count unique subsets and factors
total_unique_subsets <- growth_data %>% summarise(count = n_distinct(subset_id)) %>% pull(count)
total_unique_species <- growth_data %>% summarise(count = n_distinct(species)) %>% pull(count)
total_unique_mediums <- growth_data %>% summarise(count = n_distinct(medium)) %>% pull(count)
total_unique_citations <- growth_data %>% summarise(count = n_distinct(citation)) %>% pull(count)

# Save the cleaned, transformed dataset with numeric subset IDs
write_csv(growth_data, "../results/Cleaned_GrowthData.csv")

# Final summary report
cat("\n===== Final Data Cleaning & Transformation Summary =====\n")
cat("Original number of rows:", original_row_count, "\n")
cat("Rows removed due to non-positive values:", rows_removed, "\n")
cat("Rows remaining after cleaning:", cleaned_row_count, "\n")
cat("Total unique numeric subsets (subset_id):", total_unique_subsets, "\n")
cat("Total unique species:", total_unique_species, "\n")
cat("Total unique mediums:", total_unique_mediums, "\n")
cat("Total unique citations:", total_unique_citations, "\n")
cat("Final cleaned data saved as 'Cleaned_GrowthData.csv'\n")
